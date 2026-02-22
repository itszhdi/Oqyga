import 'package:oqyga_frontend/core/constants/app_constants.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event_ticket_type.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.address,
    // Локализация
    super.titleEn,
    super.descriptionEn,
    super.addressEn,
    super.titleKk,
    super.descriptionKk,
    super.addressKk,
    // Остальное
    required super.date,
    required super.time,
    required super.city,
    required super.minPrice,
    required super.maxPrice,
    required super.allPrices,
    required super.imageUrl,
    required super.cityId,
    required super.categoryId,
    required super.ageRatingId,
    required super.peopleAmount,
    required super.isSoldOut,
    required super.ticketTypes,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = API;
    if (!baseUrl.endsWith('/')) {
      baseUrl = '$baseUrl/';
    }

    // --- Обработка вложенных объектов ---
    final cityObject = json['city'] as Map<String, dynamic>?;
    final categoryObject = json['category'] as Map<String, dynamic>?;
    final ageObject = json['ageRestriction'] as Map<String, dynamic>?;

    // --- Обработка цен ---
    final rawMinPrice = json['minPrice'];
    final minPriceString = rawMinPrice is num
        ? rawMinPrice.toStringAsFixed(0)
        : '0';

    final rawMaxPrice = json['maxPrice'];
    final maxPriceString = rawMaxPrice is num
        ? rawMaxPrice.toStringAsFixed(0)
        : '0';

    final allPricesList =
        (json['allPrices'] as List<dynamic>?)
            ?.map((e) => (e as num).toInt())
            .toList() ??
        [];

    // --- Обработка картинки ---
    final rawImagePath = json['poster'] as String? ?? '';
    String fullImageUrl = '';
    if (rawImagePath.isNotEmpty) {
      String cleanPath = rawImagePath.replaceAll('\\', '/');
      if (cleanPath.contains('static/')) {
        cleanPath = cleanPath.split('static/').last;
      }
      if (cleanPath.startsWith('/')) {
        cleanPath = cleanPath.substring(1);
      }
      fullImageUrl = '$baseUrl$cleanPath';
    }

    // --- Обработка количества людей ---
    final rawPeople = json['peopleAmount'];
    int peopleCount = 0;
    if (rawPeople is int) {
      peopleCount = rawPeople;
    } else if (rawPeople is String) {
      peopleCount = int.tryParse(rawPeople) ?? 0;
    }

    // --- Обработка времени ---
    final rawTime = json['eventTime'] as String? ?? '00:00';
    String cleanedTime = rawTime.length >= 5
        ? rawTime.substring(0, 5)
        : rawTime;

    // --- Обработка билетов ---
    var ticketList = <EventTicketType>[];
    if (json['ticketTypes'] != null) {
      json['ticketTypes'].forEach((v) {
        ticketList.add(
          EventTicketType(
            id: v['id'] as int? ?? 0,
            description: v['description'] ?? '',
            price: (v['price'] as num).toDouble(),
            quantity: v['quantity'] ?? 0,
          ),
        );
      });
    }

    return EventModel(
      id: json['eventId'] as int? ?? 0,

      // RU (Default)
      title: json['eventName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['eventPlace'] as String? ?? '',

      // EN
      titleEn: json['eventNameEn'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      addressEn: json['eventPlaceEn'] as String?,

      // KK
      titleKk: json['eventNameKk'] as String?,
      descriptionKk: json['descriptionKk'] as String?,
      addressKk: json['eventPlaceKk'] as String?,

      // Остальные поля
      date: json['eventDate'] as String? ?? '',
      isSoldOut: json['soldOut'] ?? false,
      time: cleanedTime,
      city: cityObject?['cityName'] as String? ?? '',
      minPrice: minPriceString,
      maxPrice: maxPriceString,
      allPrices: allPricesList,
      imageUrl: fullImageUrl,
      cityId: cityObject?['cityId'] as int? ?? 0,
      categoryId: categoryObject?['categoryId'] as int? ?? 0,
      ageRatingId: ageObject?['ageId'] as int? ?? 0,
      peopleAmount: peopleCount,
      ticketTypes: ticketList,
    );
  }
}
