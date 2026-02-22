part of 'organizer_events_bloc.dart';

abstract class OrganizerEventsEvent extends Equatable {
  const OrganizerEventsEvent();
  @override
  List<Object> get props => [];
}

class FetchOrganizerEvents extends OrganizerEventsEvent {}

class DeleteOrganizerEvent extends OrganizerEventsEvent {
  final int eventId;
  const DeleteOrganizerEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}
