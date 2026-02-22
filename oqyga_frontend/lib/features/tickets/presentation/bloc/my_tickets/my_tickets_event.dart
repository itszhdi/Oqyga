part of 'my_tickets_bloc.dart';

abstract class MyTicketsEvent extends Equatable {
  const MyTicketsEvent();
  @override
  List<Object?> get props => [];
}

class FetchMyTickets extends MyTicketsEvent {
  final TicketFilters? filters;
  const FetchMyTickets({this.filters});

  @override
  List<Object?> get props => [filters];
}
