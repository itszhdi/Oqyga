import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class GetTicketDetails {
  final TicketRepository repository;
  GetTicketDetails(this.repository);
  Future<Either<Failure, TicketDetails>> call(
    int ticketId,
    String languageCode,
  ) => repository.getTicketDetails(ticketId, languageCode);
}
