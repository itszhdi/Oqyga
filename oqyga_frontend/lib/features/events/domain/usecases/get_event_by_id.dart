import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/repositories/event_repository.dart';

class GetEventById {
  final EventRepository repository;

  GetEventById(this.repository);

  Future<Either<Failure, Event>> call({
    required int eventId,
    required String languageCode,
  }) {
    return repository.getEventById(
      eventId: eventId,
      languageCode: languageCode,
    );
  }
}
