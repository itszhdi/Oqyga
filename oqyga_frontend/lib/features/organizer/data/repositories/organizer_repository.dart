import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/data/datasources/organizer_remote_data_source.dart';
import 'package:oqyga_frontend/features/organizer/data/models/create_event_request_model.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';

class OrganizerRepositoryImpl implements OrganizerRepository {
  final OrganizerRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  OrganizerRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Event>>> getMyEvents() async {
    try {
      final events = await remoteDataSource.getMyEvents();
      return Right(events);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> createEvent(CreateEventRequest request) async {
    try {
      const int placeholderId = 0;
      final requestModel = CreateEventRequestModel.fromEntity(
        request,
        organisatorId: placeholderId,
      );

      final event = await remoteDataSource.createEvent(requestModel);
      return Right(event);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint("Critical Error in createEvent: $e");
      return Left(ServerFailure("Ошибка приложения: $e"));
    }
  }

  @override
  Future<Either<Failure, Event>> updateEvent(
    int eventId,
    CreateEventRequest request,
  ) async {
    try {
      const int placeholderId = 0;
      final requestModel = CreateEventRequestModel.fromEntity(
        request,
        organisatorId: placeholderId,
      );

      final event = await remoteDataSource.updateEvent(eventId, requestModel);
      return Right(event);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint("Critical Error in updateEvent: $e");
      return Left(ServerFailure("Ошибка приложения: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(int eventId) async {
    try {
      await remoteDataSource.deleteEvent(eventId);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPreviousVenues() async {
    try {
      final places = await remoteDataSource.getPreviousVenues();
      return Right(places);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
