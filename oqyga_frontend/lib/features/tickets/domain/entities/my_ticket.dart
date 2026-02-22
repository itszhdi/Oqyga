import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/core/constants/app_constants.dart';

class MyTicket extends Equatable {
  static const _apiBaseUrl = API;

  final int ticketId;
  final String eventName;
  final String eventDate;
  final String? eventPoster;
  final String status;

  const MyTicket({
    required this.ticketId,
    required this.eventName,
    required this.eventDate,
    this.eventPoster,
    required this.status,
  });

  String? get fullPosterUrl {
    if (eventPoster == null || eventPoster!.isEmpty) return null;

    String relativePath = eventPoster!.replaceFirst('static/', '');

    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }

    return '$_apiBaseUrl/$relativePath';
  }

  @override
  List<Object?> get props => [
    ticketId,
    eventName,
    eventDate,
    eventPoster,
    status,
  ];
}
