import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/purchased_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_purchase_request.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<MyTicket>>> getMyTickets({
    TicketFilters? filters,
    required String languageCode,
  });
  Future<Either<Failure, TicketDetails>> getTicketDetails(
    int ticketId,
    String languageCode,
  );
  Future<Either<Failure, Uint8List>> getTicketQrCode(int ticketId);
  Future<Either<Failure, double>> validatePromocode(String code);

  Future<Either<Failure, PurchasedTicket>> purchaseTickets(
    TicketPurchaseRequest request,
  );
}
