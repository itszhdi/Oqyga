import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/purchased_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_purchase_request.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class PurchaseTickets {
  final TicketRepository repository;
  PurchaseTickets(this.repository);

  Future<Either<Failure, PurchasedTicket>> call(
    TicketPurchaseRequest request,
  ) => repository.purchaseTickets(request);
}
