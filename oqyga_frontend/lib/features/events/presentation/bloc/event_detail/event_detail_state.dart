part of 'event_detail_bloc.dart';

enum EventDetailStatus { initial, loading, success, failure }

class EventDetailState extends Equatable {
  final EventDetailStatus status;
  final Event? event;
  final String errorMessage;

  const EventDetailState({
    this.status = EventDetailStatus.initial,
    this.event,
    this.errorMessage = '',
  });

  EventDetailState copyWith({
    EventDetailStatus? status,
    Event? event,
    String? errorMessage,
  }) {
    return EventDetailState(
      status: status ?? this.status,
      event: event ?? this.event,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, event, errorMessage];
}
