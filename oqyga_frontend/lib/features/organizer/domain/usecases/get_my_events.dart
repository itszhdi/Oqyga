import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';

class GetMyEvents {
  final OrganizerRepository repository;
  GetMyEvents(this.repository);
  Future<Either<Failure, List<Event>>> call() => repository.getMyEvents();
}
