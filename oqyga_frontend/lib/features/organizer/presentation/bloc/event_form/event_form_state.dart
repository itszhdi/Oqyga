part of 'event_form_bloc.dart';

enum EventFormStatus { initial, loading, ready, submitting, success, failure }

class EventFormState extends Equatable {
  final EventFormStatus status;
  final Event? initialEvent;
  final List<City> cities;
  final List<Category> categories;
  final String message;
  final List<String> previousVenues;

  const EventFormState({
    this.status = EventFormStatus.initial,
    this.initialEvent,
    this.cities = const [],
    this.categories = const [],
    this.message = '',
    this.previousVenues = const [],
  });

  EventFormState copyWith({
    EventFormStatus? status,
    Event? initialEvent,
    List<City>? cities,
    List<Category>? categories,
    List<String>? previousVenues,
    String? message,
  }) {
    return EventFormState(
      status: status ?? this.status,
      initialEvent: initialEvent ?? this.initialEvent,
      cities: cities ?? this.cities,
      categories: categories ?? this.categories,
      message: message ?? this.message,
      previousVenues: previousVenues ?? this.previousVenues,
    );
  }

  @override
  List<Object?> get props => [
    status,
    initialEvent,
    cities,
    categories,
    message,
    previousVenues,
  ];
}
