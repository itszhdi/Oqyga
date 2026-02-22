import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/core/constants/app_constants.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/data/models/event_model.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getAllEvents({
    EventFilters? filters,
    required String languageCode,
  });
  Future<EventModel> getEventById({
    required int eventId,
    required String languageCode,
  });
  Future<List<EventModel>> getMyEvents({required String languageCode});
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final http.Client client; // Для публичных запросов
  final ApiClient apiClient; // Для защищенных запросов

  static const String _apiBaseUrl = API;
  static const String _apiPrefix = "/api/v1";
  static const String _basePath = "/events";

  EventRemoteDataSourceImpl({required this.client, required this.apiClient});

  @override
  Future<List<EventModel>> getAllEvents({
    EventFilters? filters,
    required String languageCode,
  }) async {
    final uri = _buildUriWithFilters(
      "$_apiBaseUrl$_apiPrefix$_basePath/all",
      filters,
    );

    try {
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Language': languageCode,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        return decoded.map((e) => EventModel.fromJson(e)).toList();
      } else {
        throw ApiException(
          message: 'failedToGetEvents',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'networkError', statusCode: 500);
    }
  }

  @override
  Future<EventModel> getEventById({
    required int eventId,
    required String languageCode,
  }) async {
    final url = Uri.parse("$_apiBaseUrl$_apiPrefix$_basePath/$eventId");
    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Language': languageCode,
        },
      );

      if (response.statusCode == 200) {
        return EventModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw ApiException(
          message: 'failedToGetEvent',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'networkError', statusCode: 500);
    }
  }

  @override
  Future<List<EventModel>> getMyEvents({required String languageCode}) async {
    try {
      final response = await apiClient.get(
        '$_basePath/my',
        headers: {'Accept-Language': languageCode},
      );

      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        return decoded.map((e) => EventModel.fromJson(e)).toList();
      } else {
        throw ApiException(
          message: 'failedToLoadMyEvents',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Uri _buildUriWithFilters(String baseUrl, EventFilters? filters) {
    if (filters == null || filters.isEmpty) {
      return Uri.parse(baseUrl);
    }

    final queryParameters = <String, String>{};

    if (filters.priceFrom != null) {
      queryParameters['priceFrom'] = filters.priceFrom!.toString();
    }
    if (filters.priceTo != null) {
      queryParameters['priceTo'] = filters.priceTo!.toString();
    }
    if (filters.cityId != null) {
      queryParameters['cityId'] = filters.cityId!.toString();
    }
    if (filters.categoryId != null) {
      queryParameters['categoryId'] = filters.categoryId!.toString();
    }
    if (filters.ageRatingId != null) {
      queryParameters['ageRatingId'] = filters.ageRatingId!.toString();
    }
    if (filters.dateFrom != null) {
      queryParameters['dateFrom'] =
          '${filters.dateFrom!.year}-${filters.dateFrom!.month.toString().padLeft(2, '0')}-${filters.dateFrom!.day.toString().padLeft(2, '0')}';
    }
    if (filters.dateTo != null) {
      queryParameters['dateTo'] =
          '${filters.dateTo!.year}-${filters.dateTo!.month.toString().padLeft(2, '0')}-${filters.dateTo!.day.toString().padLeft(2, '0')}';
    }
    if (filters.timeFrom != null) {
      queryParameters['timeFrom'] =
          '${filters.timeFrom!.hour.toString().padLeft(2, '0')}:${filters.timeFrom!.minute.toString().padLeft(2, '0')}';
    }
    if (filters.timeTo != null) {
      queryParameters['timeTo'] =
          '${filters.timeTo!.hour.toString().padLeft(2, '0')}:${filters.timeTo!.minute.toString().padLeft(2, '0')}';
    }

    return Uri.parse(baseUrl).replace(queryParameters: queryParameters);
  }
}
