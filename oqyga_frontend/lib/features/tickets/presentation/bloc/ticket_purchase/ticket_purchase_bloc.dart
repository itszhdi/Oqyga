import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event_ticket_type.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/seat.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_purchase_request.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/purchase_tickets.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/validate_promocode.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/widgets/seating_map_widget.dart';

part 'ticket_purchase_event.dart';
part 'ticket_purchase_state.dart';

class TicketPurchaseBloc
    extends Bloc<TicketPurchaseEvent, TicketPurchaseState> {
  final PurchaseTickets _purchaseTickets;
  final ValidatePromocode _validatePromocode; // UseCase для проверки
  final AuthBloc _authBloc;

  TicketPurchaseBloc({
    required PurchaseTickets purchaseTickets,
    required ValidatePromocode validatePromocode,
    required AuthBloc authBloc,
  }) : _purchaseTickets = purchaseTickets,
       _validatePromocode = validatePromocode,
       _authBloc = authBloc,
       super(const TicketPurchaseState()) {
    on<PurchaseFlowStarted>(_onPurchaseFlowStarted);
    on<SeatToggled>(_onSeatToggled);
    on<PromocodeSubmitted>(_onPromocodeSubmitted);
    on<PurchaseSubmitted>(_onPurchaseSubmitted);
  }

  void _onPurchaseFlowStarted(
    PurchaseFlowStarted event,
    Emitter<TicketPurchaseState> emit,
  ) {
    if (event.event.ticketTypes.isEmpty) {
      emit(
        state.copyWith(
          status: TicketPurchaseStatus.failure,
          errorMessage: 'noTicketPriceInfo',
        ),
      );
      return;
    }

    final sortedTypes = List<EventTicketType>.from(event.event.ticketTypes)
      ..sort((a, b) => b.price.compareTo(a.price));

    final prices = sortedTypes.map((e) => e.price.toInt()).toList();

    final List<List<Seat>> seatingMap = getSeatingMapByPrices(prices);

    emit(
      state.copyWith(
        status: TicketPurchaseStatus.selecting,
        event: event.event,
        sortedTicketTypes: sortedTypes,
        seatingMap: seatingMap,
        selectedSeats: [],
        totalPrice: 0,
        appliedPromocode: '',
        discountAmount: 0,
      ),
    );
  }

  void _onSeatToggled(SeatToggled event, Emitter<TicketPurchaseState> emit) {
    final newMap = List<List<Seat>>.from(
      state.seatingMap.map((row) => List<Seat>.from(row)),
    );
    final seat = newMap[event.row - 1][event.number - 1];

    if (seat.isBooked) return;

    newMap[event.row - 1][event.number - 1] = seat.copyWith(
      isSelected: !seat.isSelected,
    );

    final selectedSeats = newMap
        .expand((row) => row)
        .where((s) => s.isSelected)
        .toList();

    final totalPrice = selectedSeats.fold<double>(
      0,
      (sum, seat) => sum + seat.price,
    );

    emit(
      state.copyWith(
        seatingMap: newMap,
        selectedSeats: selectedSeats,
        totalPrice: totalPrice,
      ),
    );
  }

  Future<void> _onPromocodeSubmitted(
    PromocodeSubmitted event,
    Emitter<TicketPurchaseState> emit,
  ) async {
    if (event.code.trim().isEmpty) return;

    emit(state.copyWith(isPromocodeLoading: true, errorMessage: ''));

    final result = await _validatePromocode(event.code);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isPromocodeLoading: false,
            errorMessage: 'invalidPromocode', // Или failure.message
            discountAmount: 0,
            appliedPromocode: '',
          ),
        );
      },
      (discount) {
        emit(
          state.copyWith(
            isPromocodeLoading: false,
            discountAmount: discount,
            appliedPromocode: event.code,
            errorMessage: '', // Очищаем ошибки, если успешно
          ),
        );
      },
    );
  }

  Future<void> _onPurchaseSubmitted(
    PurchaseSubmitted event,
    Emitter<TicketPurchaseState> emit,
  ) async {
    final user = _authBloc.state.user;

    if (user.isEmpty) {
      emit(
        state.copyWith(
          status: TicketPurchaseStatus.failure,
          errorMessage: 'userNotAuthorized',
        ),
      );
      return;
    }

    if (state.selectedSeats.isEmpty) {
      emit(
        state.copyWith(
          status: TicketPurchaseStatus.failure,
          errorMessage: 'seatsNotSelected',
        ),
      );
      return;
    }

    if (state.totalPrice > 0 &&
        event.savedCardId == null &&
        event.newPaymentMethodId == null) {
      emit(
        state.copyWith(
          status: TicketPurchaseStatus.failure,
          errorMessage:
              'choosePaymentMethod', // Добавьте этот ключ в локализацию
        ),
      );
      return;
    }

    emit(state.copyWith(status: TicketPurchaseStatus.processing));

    final List<PurchaseSeatRequest> seatsToSend = [];

    for (var seat in state.selectedSeats) {
      if (seat.priceIndex < state.sortedTicketTypes.length) {
        final ticketTypeId = state.sortedTicketTypes[seat.priceIndex].id;
        seatsToSend.add(
          PurchaseSeatRequest(
            ticketTypeId: ticketTypeId,
            row: seat.row,
            number: seat.number,
          ),
        );
      }
    }

    final request = TicketPurchaseRequest(
      eventId: state.event!.id,
      userId: user.id,
      seats: seatsToSend,
      promocode: state.appliedPromocode,
      savedCardId: event.savedCardId,
      newPaymentMethodId: event.newPaymentMethodId,
      saveNewCard: event.saveNewCard,
    );

    final result = await _purchaseTickets(request);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: TicketPurchaseStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (purchasedTicket) {
        final ticketIds = [purchasedTicket.ticketId];
        emit(
          state.copyWith(
            status: TicketPurchaseStatus.success,
            purchasedTicketIds: ticketIds,
          ),
        );
      },
    );
  }
}
