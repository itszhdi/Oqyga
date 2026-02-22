part of 'ticket_detail_bloc.dart';

enum TicketDetailStatus { initial, loading, success, failure }

class TicketDetailState extends Equatable {
  final TicketDetailStatus status;
  final TicketDetails? details;
  final Uint8List? qrCodeBytes;
  final String errorMessage;

  const TicketDetailState({
    this.status = TicketDetailStatus.initial,
    this.details,
    this.qrCodeBytes,
    this.errorMessage = '',
  });

  TicketDetailState copyWith({
    TicketDetailStatus? status,
    TicketDetails? details,
    Uint8List? qrCodeBytes,
    String? errorMessage,
  }) {
    return TicketDetailState(
      status: status ?? this.status,
      details: details ?? this.details,
      qrCodeBytes: qrCodeBytes ?? this.qrCodeBytes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, details, qrCodeBytes, errorMessage];
}