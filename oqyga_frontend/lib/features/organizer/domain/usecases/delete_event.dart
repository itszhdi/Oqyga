import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';

class DeleteEvent {
  final OrganizerRepository repository;
  DeleteEvent(this.repository);
  Future<Either<Failure, void>> call(int eventId) =>
      repository.deleteEvent(eventId);
}
