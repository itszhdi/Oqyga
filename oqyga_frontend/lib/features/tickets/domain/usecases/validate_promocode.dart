import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class ValidatePromocode {
  final TicketRepository repository;
  ValidatePromocode(this.repository);
  Future<Either<Failure, double>> call(String code) =>
      repository.validatePromocode(code);
}
