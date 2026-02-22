import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:oqyga_frontend/features/tickets/data/models/ticket_purchase_request_model.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/purchased_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_purchase_request.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MyTicket>>> getMyTickets({
    TicketFilters? filters,
    required String languageCode,
  }) async {
    try {
      final queryParams = (filters == null || filters.isEmpty)
          ? null
          : filters.toQueryParameters();

      final tickets = await remoteDataSource.getMyTickets(
        queryParams: queryParams,
        languageCode: languageCode,
      );
      return Right(tickets);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TicketDetails>> getTicketDetails(
    int ticketId,
    String languageCode,
  ) async {
    try {
      final details = await remoteDataSource.getTicketDetails(
        ticketId,
        languageCode,
      );
      return Right(details);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> getTicketQrCode(int ticketId) async {
    try {
      final qrCode = await remoteDataSource.getTicketQrCode(ticketId);
      return Right(qrCode);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, double>> validatePromocode(String code) async {
    try {
      final discount = await remoteDataSource.validatePromocode(code);
      return Right(discount);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PurchasedTicket>> purchaseTickets(
    TicketPurchaseRequest request,
  ) async {
    try {
      final requestModel = TicketPurchaseRequestModel(
        eventId: request.eventId,
        userId: request.userId,
        seats: request.seats,
        promocode: request.promocode,
        savedCardId: request.savedCardId,
        newPaymentMethodId: request.newPaymentMethodId,
        saveNewCard: request.saveNewCard,
      );

      final ticket = await remoteDataSource.purchaseTickets(requestModel);
      return Right(ticket);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
