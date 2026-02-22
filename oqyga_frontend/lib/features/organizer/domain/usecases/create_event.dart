import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';

class CreateEvent {
  final OrganizerRepository repository;
  CreateEvent(this.repository);
  Future<Either<Failure, Event>> call(CreateEventRequest request) =>
      repository.createEvent(request);
}
