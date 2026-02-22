import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event_ticket_type.dart';

class Event extends Equatable {
  final int id;

  // Основные (обычно RU)
  final String title;
  final String description;
  final String address;

  // Английская версия
  final String? titleEn;
  final String? descriptionEn;
  final String? addressEn;

  // Казахская версия
  final String? titleKk;
  final String? descriptionKk;
  final String? addressKk;

  final String date;
  final String time;
  final String city;
  final String minPrice;
  final String maxPrice;
  final List<int> allPrices;
  final String imageUrl;
  final int cityId;
  final int categoryId;
  final int ageRatingId;
  final int peopleAmount;
  final List<EventTicketType> ticketTypes;
  final bool isSoldOut;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    this.titleEn,
    this.descriptionEn,
    this.addressEn,
    this.titleKk,
    this.descriptionKk,
    this.addressKk,
    required this.date,
    required this.time,
    required this.city,
    required this.minPrice,
    required this.maxPrice,
    required this.allPrices,
    required this.imageUrl,
    required this.cityId,
    required this.categoryId,
    required this.ageRatingId,
    required this.peopleAmount,
    this.isSoldOut = false,
    this.ticketTypes = const [],
  });

  /// Получение названия на нужном языке
  String getLocalizedTitle(String langCode) {
    switch (langCode) {
      case 'en':
        return (titleEn != null && titleEn!.isNotEmpty) ? titleEn! : title;
      case 'kk':
        return (titleKk != null && titleKk!.isNotEmpty) ? titleKk! : title;
      default:
        return title;
    }
  }

  /// Получение описания на нужном языке
  String getLocalizedDescription(String langCode) {
    switch (langCode) {
      case 'en':
        return (descriptionEn != null && descriptionEn!.isNotEmpty)
            ? descriptionEn!
            : description;
      case 'kk':
        return (descriptionKk != null && descriptionKk!.isNotEmpty)
            ? descriptionKk!
            : description;
      default:
        return description;
    }
  }

  /// Получение адреса (места) на нужном языке
  String getLocalizedAddress(String langCode) {
    switch (langCode) {
      case 'en':
        return (addressEn != null && addressEn!.isNotEmpty)
            ? addressEn!
            : address;
      case 'kk':
        return (addressKk != null && addressKk!.isNotEmpty)
            ? addressKk!
            : address;
      default:
        return address;
    }
  }

  String get priceRange {
    if (minPrice == maxPrice) {
      return '$minPrice ₸';
    }
    return '$minPrice - $maxPrice ₸';
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    address,
    titleEn,
    descriptionEn,
    addressEn,
    titleKk,
    descriptionKk,
    addressKk,
    date,
    time,
    city,
    minPrice,
    maxPrice,
    imageUrl,
    peopleAmount,
    isSoldOut,
    ticketTypes,
  ];
}
