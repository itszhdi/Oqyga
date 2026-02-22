import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/data/datasources/event_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/repositories/event_repository.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Event>>> getAllEvents({
    EventFilters? filters,
    required String languageCode,
  }) async {
    try {
      final events = await remoteDataSource.getAllEvents(
        filters: filters,
        languageCode: languageCode,
      );
      return Right(events);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById({
    required int eventId,
    required String languageCode,
  }) async {
    try {
      final event = await remoteDataSource.getEventById(
        eventId: eventId,
        languageCode: languageCode,
      );
      return Right(event);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getMyEvents({
    required String languageCode,
  }) async {
    try {
      final events = await remoteDataSource.getMyEvents(
        languageCode: languageCode,
      );
      return Right(events);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
