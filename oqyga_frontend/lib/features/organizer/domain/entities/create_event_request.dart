import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/organizer/domain/entities/ticket_type_request.dart';

class CreateEventRequest extends Equatable {
  final String title;
  final String? date;
  final String? time;
  final int? cityId;
  final int? categoryId;
  final List<TicketTypeRequest> ticketTypes;
  final String? address;
  final String? seats;
  final String? description;
  final File? posterImage;
  final String? existingPosterUrl;

  const CreateEventRequest({
    required this.title,
    this.date,
    this.time,
    this.cityId,
    this.categoryId,
    this.ticketTypes = const [],
    this.address,
    this.seats,
    this.description,
    this.posterImage,
    this.existingPosterUrl,
  });

  @override
  List<Object?> get props => [
    title,
    date,
    time,
    cityId,
    categoryId,
    ticketTypes,
    address,
    seats,
    description,
    posterImage,
    existingPosterUrl,
  ];
}
