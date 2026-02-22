import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/delete_event.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/get_my_events.dart';

part 'organizer_events_event.dart';
part 'organizer_events_state.dart';

class OrganizerEventsBloc
    extends Bloc<OrganizerEventsEvent, OrganizerEventsState> {
  final GetMyEvents _getMyEvents;
  final DeleteEvent _deleteEvent;

  OrganizerEventsBloc({
    required GetMyEvents getMyEvents,
    required DeleteEvent deleteEvent,
  }) : _getMyEvents = getMyEvents,
       _deleteEvent = deleteEvent,
       super(const OrganizerEventsState()) {
    on<FetchOrganizerEvents>(_onFetchOrganizerEvents);
    on<DeleteOrganizerEvent>(_onDeleteOrganizerEvent);
  }

  Future<void> _onFetchOrganizerEvents(
    FetchOrganizerEvents event,
    Emitter<OrganizerEventsState> emit,
  ) async {
    emit(state.copyWith(status: OrganizerEventsStatus.loading));
    final result = await _getMyEvents();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrganizerEventsStatus.failure,
          message: failure.message,
        ),
      ),
      (events) => emit(
        state.copyWith(status: OrganizerEventsStatus.success, events: events),
      ),
    );
  }

  Future<void> _onDeleteOrganizerEvent(
    DeleteOrganizerEvent event,
    Emitter<OrganizerEventsState> emit,
  ) async {
    emit(state.copyWith(status: OrganizerEventsStatus.deleting));
    final result = await _deleteEvent(event.eventId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OrganizerEventsStatus.failure,
          message: failure.message,
        ),
      ),
      (_) {
        // После успешного удаления обновляем список
        add(FetchOrganizerEvents());
      },
    );
  }
}
