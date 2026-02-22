import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';

class MyTicketModel extends MyTicket {
  const MyTicketModel({
    required super.ticketId,
    required super.eventName,
    required super.eventDate,
    super.eventPoster,
    required super.status,
  });

  factory MyTicketModel.fromJson(Map<String, dynamic> json) => MyTicketModel(
    ticketId: json["ticketId"],
    eventName: json["eventName"],
    eventDate: json["eventDate"],
    eventPoster: json["eventPoster"],
    status: json["status"],
  );
}
