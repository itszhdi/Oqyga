import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';

class TicketDetailsModel extends TicketDetails {
  const TicketDetailsModel({
    required super.userId,
    required super.eventId,
    required super.eventName,
    required super.eventDate,
    required super.eventTime,
    super.posterUrl,
    required super.eventLocation,
    required super.totalTickets,
    required super.ticketGroups,
  });

  factory TicketDetailsModel.fromJson(Map<String, dynamic> json) =>
      TicketDetailsModel(
        userId: json["userId"],
        eventId: json["eventId"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        eventTime: json["eventTime"],
        posterUrl: json["posterUrl"],
        eventLocation: json["eventLocation"],
        totalTickets: json["totalTickets"],
        ticketGroups: List<TicketGroupModel>.from(
          json["ticketGroups"].map((x) => TicketGroupModel.fromJson(x)),
        ),
      );
}

class TicketGroupModel extends TicketGroup {
  const TicketGroupModel({
    required super.price,
    required super.quantity,
    required super.seatDetails,
  });

  factory TicketGroupModel.fromJson(Map<String, dynamic> json) =>
      TicketGroupModel(
        price: (json["price"] as num).toDouble(),
        quantity: json["quantity"],
        seatDetails: json["seatDetails"],
      );
}
