import 'dart:convert';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/events/data/models/event_model.dart';

abstract class MapRemoteDataSource {
  Future<List<EventModel>> getEventsByCity(int cityId, String languageCode);
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final ApiClient apiClient;

  MapRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<EventModel>> getEventsByCity(
    int cityId,
    String languageCode,
  ) async {
    final response = await apiClient.get(
      "/events/all?cityId=$cityId",
      headers: {'Accept-Language': languageCode},
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonList.map((json) => EventModel.fromJson(json)).toList();
    } else {
      throw Exception("Ошибка загрузки мероприятий");
    }
  }
}
