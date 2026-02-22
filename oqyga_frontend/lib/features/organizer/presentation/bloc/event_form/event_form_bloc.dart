import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/create_event.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/get_previous_venues.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/update_event.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/repositories/filter_repository.dart';

part 'event_form_event.dart';
part 'event_form_state.dart';

class EventFormBloc extends Bloc<EventFormEvent, EventFormState> {
  final CreateEvent _createEvent;
  final UpdateEvent _updateEvent;
  final FilterRepository _filterRepository;
  final GetPreviousVenues getPreviousVenues;
  final languageCode = Intl.getCurrentLocale().substring(0, 2);

  EventFormBloc({
    required CreateEvent createEvent,
    required UpdateEvent updateEvent,
    required FilterRepository filterRepository,
    required this.getPreviousVenues,
  }) : _createEvent = createEvent,
       _updateEvent = updateEvent,
       _filterRepository = filterRepository,
       super(const EventFormState()) {
    on<LoadEventForEdit>(_onLoadEventForEdit);
    on<FormSubmitted>(_onFormSubmitted);
    on<InitializeEventForm>(_onInitialize);
  }

  Future<void> _onInitialize(
    InitializeEventForm event,
    Emitter<EventFormState> emit,
  ) async {
    emit(state.copyWith(status: EventFormStatus.loading, message: ''));

    final filtersResult = await _filterRepository.getFilterOptions(languageCode);
    final venuesResult = await getPreviousVenues();

    List<City> cities = [];
    List<Category> categories = [];
    filtersResult.fold((l) => null, (r) {
      cities = r.cities;
      categories = r.categories;
    });

    // Обработка мест
    List<String> venues = [];
    venuesResult.fold(
      (l) => print("Ошибка загрузки мест: ${l.message}"),
      (r) => venues = r,
    );

    emit(
      state.copyWith(
        status: EventFormStatus.ready,
        cities: cities,
        categories: categories,
        previousVenues: venues,
        initialEvent: event.eventToEdit,
      ),
    );
  }

  void _onLoadEventForEdit(
    LoadEventForEdit event,
    Emitter<EventFormState> emit,
  ) {
    emit(state.copyWith(initialEvent: event.event));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<EventFormState> emit,
  ) async {
    emit(state.copyWith(status: EventFormStatus.submitting));

    final result = event.isEditMode
        ? await _updateEvent(event.eventId!, event.request)
        : await _createEvent(event.request);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EventFormStatus.failure,
          message: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: EventFormStatus.success)),
    );
  }
}
