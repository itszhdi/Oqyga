import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrganizerFilters extends Equatable {
  final int? cityId;
  final int? categoryId;
  final int? ageRatingId;
  final String? venueAddress;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;

  const OrganizerFilters({
    this.cityId,
    this.categoryId,
    this.ageRatingId,
    this.venueAddress,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
  });

  bool get isEmpty =>
      cityId == null &&
      categoryId == null &&
      ageRatingId == null &&
      venueAddress == null &&
      dateFrom == null &&
      dateTo == null &&
      timeFrom == null &&
      timeTo == null;

  @override
  List<Object?> get props => [
    cityId,
    categoryId,
    ageRatingId,
    venueAddress,
    dateFrom,
    dateTo,
    timeFrom,
    timeTo,
  ];
}
