import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/usecases/get_all_events.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventsListBloc extends Bloc<EventsListEvent, EventsListState> {
  final GetAllEvents _getAllEvents;

  EventsListBloc({required GetAllEvents getAllEvents})
    : _getAllEvents = getAllEvents,
      super(const EventsListState()) {
    on<FetchEvents>(_onFetchEvents);
  }

  Future<void> _onFetchEvents(
    FetchEvents event,
    Emitter<EventsListState> emit,
  ) async {
    emit(state.copyWith(status: EventsListStatus.loading));

    final String languageCode = Intl.getCurrentLocale().substring(0, 2);

    final result = await _getAllEvents(
      filters: event.filters,
      languageCode: languageCode,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EventsListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (events) => emit(
        state.copyWith(status: EventsListStatus.success, events: events),
      ),
    );
  }
}
