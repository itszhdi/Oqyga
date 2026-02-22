part of 'event_list_bloc.dart';

enum EventsListStatus { initial, loading, success, failure }

class EventsListState extends Equatable {
  final EventsListStatus status;
  final List<Event> events;
  final String errorMessage;

  const EventsListState({
    this.status = EventsListStatus.initial,
    this.events = const <Event>[],
    this.errorMessage = '',
  });

  EventsListState copyWith({
    EventsListStatus? status,
    List<Event>? events,
    String? errorMessage,
  }) {
    return EventsListState(
      status: status ?? this.status,
      events: events ?? this.events,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, events, errorMessage];
}
