part of 'event_list_bloc.dart';

abstract class EventsListEvent extends Equatable {
  const EventsListEvent();

  @override
  List<Object> get props => [];
}

class FetchEvents extends EventsListEvent {
  final EventFilters? filters;
  const FetchEvents({this.filters});
}
