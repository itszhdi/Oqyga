part of 'event_form_bloc.dart';

abstract class EventFormEvent extends Equatable {
  const EventFormEvent();
  @override
  List<Object?> get props => [];
}

class InitializeEventForm extends EventFormEvent {
  final Event? eventToEdit;

  const InitializeEventForm({this.eventToEdit});

  @override
  List<Object?> get props => [eventToEdit];
}

class LoadEventForEdit extends EventFormEvent {
  final Event event;
  const LoadEventForEdit(this.event);

  @override
  List<Object> get props => [event];
}

class FormSubmitted extends EventFormEvent {
  final CreateEventRequest request;
  final bool isEditMode;
  final int? eventId;

  const FormSubmitted({
    required this.request,
    required this.isEditMode,
    this.eventId,
  });

  @override
  List<Object?> get props => [request, isEditMode, eventId];
}
