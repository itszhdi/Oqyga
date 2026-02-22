import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TicketFilters extends Equatable {
  final String? status;
  final int? cityId;
  final int? categoryId;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final TimeOfDay? timeFrom;
  final TimeOfDay? timeTo;

  const TicketFilters({
    this.status,
    this.cityId,
    this.categoryId,
    this.dateFrom,
    this.dateTo,
    this.timeFrom,
    this.timeTo,
  });

  Map<String, String> toQueryParameters() {
    final Map<String, String> params = {};
    if (status != null) params['status'] = status!;
    if (cityId != null) params['cityId'] = cityId!.toString();
    if (categoryId != null) params['categoryId'] = categoryId!.toString();
    if (dateFrom != null)
      params['dateFrom'] = dateFrom!.toIso8601String().substring(0, 10);
    if (dateTo != null)
      params['dateTo'] = dateTo!.toIso8601String().substring(0, 10);
    if (timeFrom != null)
      params['timeFrom'] =
          '${timeFrom!.hour.toString().padLeft(2, '0')}:${timeFrom!.minute.toString().padLeft(2, '0')}';
    if (timeTo != null)
      params['timeTo'] =
          '${timeTo!.hour.toString().padLeft(2, '0')}:${timeTo!.minute.toString().padLeft(2, '0')}';
    return params;
  }

  bool get isEmpty =>
      status == null &&
      cityId == null &&
      categoryId == null &&
      dateFrom == null &&
      dateTo == null &&
      timeFrom == null &&
      timeTo == null;

  @override
  List<Object?> get props => [
    status,
    cityId,
    categoryId,
    dateFrom,
    dateTo,
    timeFrom,
    timeTo,
  ];
}
