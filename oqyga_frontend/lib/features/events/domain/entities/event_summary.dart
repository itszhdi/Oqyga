import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';

class EventSummary extends Equatable {
  final int id;
  final String title;
  final String date;
  final String time;
  final String address;
  final String city;
  final String priceRange;
  final List<int> allPrices;

  const EventSummary({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.city,
    required this.address,
    required this.priceRange,
    required this.allPrices,
  });

  factory EventSummary.fromEvent(Event event) {
    return EventSummary(
      id: event.id,
      title: event.title,
      date: event.date,
      time: event.time,
      city: event.city,
      address: event.address,
      priceRange: event.priceRange,
      allPrices: event.allPrices,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    date,
    time,
    city,
    address,
    priceRange,
    allPrices,
  ];
}
