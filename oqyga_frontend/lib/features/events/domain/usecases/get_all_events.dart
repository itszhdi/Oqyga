import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/repositories/event_repository.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';

class GetAllEvents {
  final EventRepository repository;

  GetAllEvents(this.repository);

  Future<Either<Failure, List<Event>>> call({
    EventFilters? filters,
    required String languageCode,
  }) {
    return repository.getAllEvents(
      filters: filters,
      languageCode: languageCode,
    );
  }
}
