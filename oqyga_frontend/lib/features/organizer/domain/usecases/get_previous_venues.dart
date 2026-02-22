import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';

class GetPreviousVenues {
  final OrganizerRepository repository;

  GetPreviousVenues(this.repository);

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getPreviousVenues();
  }
}
