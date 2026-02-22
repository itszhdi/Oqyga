import 'package:equatable/equatable.dart';

class PurchasedTicket extends Equatable {
  final int ticketId;
  final double price;
  final int quantity;
  final String seatDetails;
  final int userId;
  final int eventId;

  const PurchasedTicket({
    required this.ticketId,
    required this.price,
    required this.quantity,
    required this.seatDetails,
    required this.userId,
    required this.eventId,
  });

  @override
  List<Object?> get props => [ticketId];
}
