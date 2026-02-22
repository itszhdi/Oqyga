import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventFilters extends Equatable {
  final double? priceFrom;
  final double? priceTo;
  final int? cityId;
  final int? categoryId;
  final int? ageRatingId;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;

  const EventFilters({
    this.priceFrom,
    this.priceTo,
    this.cityId,
    this.categoryId,
    this.ageRatingId,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
  });

  bool get isEmpty =>
      priceFrom == null &&
      priceTo == null &&
      cityId == null &&
      categoryId == null &&
      ageRatingId == null &&
      dateFrom == null &&
      dateTo == null &&
      timeFrom == null &&
      timeTo == null;

  @override
  List<Object?> get props => [
    priceFrom,
    priceTo,
    cityId,
    categoryId,
    ageRatingId,
    dateFrom,
    dateTo,
    timeFrom,
    timeTo,
  ];
}
