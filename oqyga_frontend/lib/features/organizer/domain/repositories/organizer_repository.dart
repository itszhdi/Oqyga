import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';

abstract class OrganizerRepository {
  Future<Either<Failure, List<Event>>> getMyEvents();
  Future<Either<Failure, Event>> createEvent(CreateEventRequest request);
  Future<Either<Failure, Event>> updateEvent(
    int eventId,
    CreateEventRequest request,
  );
  Future<Either<Failure, void>> deleteEvent(int eventId);
  Future<Either<Failure, List<String>>> getPreviousVenues();
}
