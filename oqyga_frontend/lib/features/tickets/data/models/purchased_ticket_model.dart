import 'package:oqyga_frontend/features/tickets/domain/entities/purchased_ticket.dart';

class PurchasedTicketModel extends PurchasedTicket {
  const PurchasedTicketModel({
    required super.ticketId,
    required super.price,
    required super.quantity,
    required super.seatDetails,
    required super.userId,
    required super.eventId,
  });

  factory PurchasedTicketModel.fromJson(Map<String, dynamic> json) {
    return PurchasedTicketModel(
      ticketId: json["ticketId"],
      price: (json["price"] as num).toDouble(),
      quantity: json["quantity"],
      seatDetails: json["seatDetails"],
      userId: json["userId"],
      eventId: json["eventId"],
    );
  }
}
