import 'package:oqyga_frontend/features/organizer/domain/entities/create_event_request.dart';

class CreateEventRequestModel extends CreateEventRequest {
  final int organisatorId;

  const CreateEventRequestModel({
    required super.title,
    required this.organisatorId,
    super.date,
    super.time,
    super.cityId,
    super.categoryId,
    super.ticketTypes,
    super.address,
    super.seats,
    super.description,
    super.posterImage,
    super.existingPosterUrl,
  });

  factory CreateEventRequestModel.fromEntity(
    CreateEventRequest request, {
    required int organisatorId,
  }) {
    return CreateEventRequestModel(
      title: request.title,
      organisatorId: organisatorId,
      date: request.date,
      time: request.time,
      cityId: request.cityId,
      categoryId: request.categoryId,
      ticketTypes: request.ticketTypes,
      address: request.address,
      seats: request.seats,
      description: request.description,
      posterImage: request.posterImage,
      existingPosterUrl: request.existingPosterUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventName': title,
      'eventDate': date,
      'eventTime': time,
      'event_place': address,
      'description': description,
      'peopleAmount': int.tryParse(seats ?? '0'),

      'ticketTypes': ticketTypes.map((e) => e.toJson()).toList(),

      'ageRestrictionId': 1,
      'categoryId': categoryId,
      'cityId': cityId,
      'organisatorId': organisatorId,
    }..removeWhere((key, value) => value == null);
  }
}
