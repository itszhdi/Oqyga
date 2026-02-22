part of 'my_tickets_bloc.dart';

enum MyTicketsStatus { initial, loading, success, failure }

class MyTicketsState extends Equatable {
  final MyTicketsStatus status;
  final List<MyTicket> tickets;
  final String errorMessage;

  const MyTicketsState({
    this.status = MyTicketsStatus.initial,
    this.tickets = const [],
    this.errorMessage = '',
  });

  MyTicketsState copyWith({
    MyTicketsStatus? status,
    List<MyTicket>? tickets,
    String? errorMessage,
  }) {
    return MyTicketsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, tickets, errorMessage];
}
