import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/core/constants/app_constants.dart';

class TicketDetails extends Equatable {
  static const _apiBaseUrl = API;

  final int userId;
  final int eventId;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String? posterUrl;
  final String eventLocation;
  final int totalTickets;
  final List<TicketGroup> ticketGroups;

  const TicketDetails({
    required this.userId,
    required this.eventId,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    this.posterUrl,
    required this.eventLocation,
    required this.totalTickets,
    required this.ticketGroups,
  });

  String? get fullPosterUrl {
    if (posterUrl == null || posterUrl!.isEmpty) return null;

    String relativePath = posterUrl!.replaceFirst('static/', '');

    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }

    return '$_apiBaseUrl/$relativePath';
  }

  String get eventDateTime => '$eventDate, $eventTime';
  String get allSeatDetails =>
      ticketGroups.map((g) => g.seatDetails).join('; ');

  @override
  List<Object?> get props => [
    eventId,
    eventName,
    eventDate,
    eventTime,
    posterUrl,
  ];
}

class TicketGroup extends Equatable {
  final double price;
  final int quantity;
  final String seatDetails;

  const TicketGroup({
    required this.price,
    required this.quantity,
    required this.seatDetails,
  });

  @override
  List<Object?> get props => [price, quantity, seatDetails];
}
