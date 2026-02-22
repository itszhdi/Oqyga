part of 'organizer_events_bloc.dart';

enum OrganizerEventsStatus { initial, loading, success, failure, deleting }

class OrganizerEventsState extends Equatable {
  final OrganizerEventsStatus status;
  final List<Event> events;
  final String message;

  const OrganizerEventsState({
    this.status = OrganizerEventsStatus.initial,
    this.events = const [],
    this.message = '',
  });

  OrganizerEventsState copyWith({
    OrganizerEventsStatus? status,
    List<Event>? events,
    String? message,
  }) {
    return OrganizerEventsState(
      status: status ?? this.status,
      events: events ?? this.events,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, events, message];
}
