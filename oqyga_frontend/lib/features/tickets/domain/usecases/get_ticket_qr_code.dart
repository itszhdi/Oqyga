import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';

class GetTicketQrCode {
  final TicketRepository repository;
  GetTicketQrCode(this.repository);
  Future<Either<Failure, Uint8List>> call(int ticketId) =>
      repository.getTicketQrCode(ticketId);
}
