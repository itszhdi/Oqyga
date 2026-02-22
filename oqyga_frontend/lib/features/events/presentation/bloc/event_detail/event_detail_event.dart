part of 'event_detail_bloc.dart';

abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchEventById extends EventDetailEvent {
  final int eventId;
  const FetchEventById(this.eventId);

  @override
  List<Object> get props => [eventId];
}
