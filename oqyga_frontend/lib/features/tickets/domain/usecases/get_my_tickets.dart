import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class GetMyTickets {
  final TicketRepository repository;
  GetMyTickets(this.repository);
  Future<Either<Failure, List<MyTicket>>> call({
    TicketFilters? filters,
    required String languageCode,
  }) {
    return repository.getMyTickets(
      filters: filters,
      languageCode: languageCode,
    );
  }
}
