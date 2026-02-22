part of 'ticket_detail_bloc.dart';

abstract class TicketDetailEvent extends Equatable {
  const TicketDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchTicketData extends TicketDetailEvent {
  final int ticketId;
  const FetchTicketData(this.ticketId);

  @override
  List<Object> get props => [ticketId];
}
