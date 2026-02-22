import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_my_tickets.dart';

part 'my_tickets_event.dart';
part 'my_tickets_state.dart';

class MyTicketsBloc extends Bloc<MyTicketsEvent, MyTicketsState> {
  final GetMyTickets _getMyTickets;

  MyTicketsBloc({required GetMyTickets getMyTickets})
    : _getMyTickets = getMyTickets,
      super(const MyTicketsState()) {
    on<FetchMyTickets>(_onFetchMyTickets);
  }

  Future<void> _onFetchMyTickets(
    FetchMyTickets event,
    Emitter<MyTicketsState> emit,
  ) async {
    emit(state.copyWith(status: MyTicketsStatus.loading));
    final String currentLang = Intl.getCurrentLocale().substring(0, 2);
    final result = await _getMyTickets(
      filters: event.filters,
      languageCode: currentLang,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: MyTicketsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (tickets) => emit(
        state.copyWith(status: MyTicketsStatus.success, tickets: tickets),
      ),
    );
  }
}
