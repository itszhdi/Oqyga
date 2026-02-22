import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/usecases/get_event_by_id.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final GetEventById _getEventById;

  EventDetailBloc({required GetEventById getEventById})
    : _getEventById = getEventById,
      super(const EventDetailState()) {
    on<FetchEventById>(_onFetchEventById);
  }

  Future<void> _onFetchEventById(
    FetchEventById event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(state.copyWith(status: EventDetailStatus.loading));

    final String languageCode = Intl.getCurrentLocale().substring(0, 2);

    final result = await _getEventById(
      eventId: event.eventId,
      languageCode: languageCode,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EventDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (event) =>
          emit(state.copyWith(status: EventDetailStatus.success, event: event)),
    );
  }
}
