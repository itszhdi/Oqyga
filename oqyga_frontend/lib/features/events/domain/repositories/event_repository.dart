import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getAllEvents({
    EventFilters? filters,
    required String languageCode,
  });

  Future<Either<Failure, Event>> getEventById({
    required int eventId,
    required String languageCode,
  });

  Future<Either<Failure, List<Event>>> getMyEvents({
    required String languageCode,
  });
}
