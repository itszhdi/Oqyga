import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_ticket_qr_code.dart';

part 'ticket_detail_event.dart';
part 'ticket_detail_state.dart';

class TicketDetailBloc extends Bloc<TicketDetailEvent, TicketDetailState> {
  final GetTicketDetails _getTicketDetails;
  final GetTicketQrCode _getTicketQrCode;

  TicketDetailBloc({
    required GetTicketDetails getTicketDetails,
    required GetTicketQrCode getTicketQrCode,
  }) : _getTicketDetails = getTicketDetails,
       _getTicketQrCode = getTicketQrCode,
       super(const TicketDetailState()) {
    on<FetchTicketData>(_onFetchTicketData);
  }

  Future<void> _onFetchTicketData(
    FetchTicketData event,
    Emitter<TicketDetailState> emit,
  ) async {
    emit(state.copyWith(status: TicketDetailStatus.loading));
    final String languageCode = Intl.getCurrentLocale().substring(0, 2);

    final results = await Future.wait([
      _getTicketDetails(event.ticketId, languageCode),
      _getTicketQrCode(event.ticketId),
    ]);

    final detailsResult = results[0] as Either<Failure, TicketDetails>;
    final qrCodeResult = results[1] as Either<Failure, Uint8List>;

    detailsResult.fold(
      (failure) => emit(
        state.copyWith(
          status: TicketDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (details) {
        qrCodeResult.fold(
          (failure) => emit(
            state.copyWith(
              status: TicketDetailStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (qrCode) => emit(
            state.copyWith(
              status: TicketDetailStatus.success,
              details: details,
              qrCodeBytes: qrCode,
            ),
          ),
        );
      },
    );
  }
}
