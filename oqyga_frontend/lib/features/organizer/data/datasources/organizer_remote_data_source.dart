import 'dart:convert';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/data/models/event_model.dart';
import 'package:oqyga_frontend/features/organizer/data/models/create_event_request_model.dart';

abstract class OrganizerRemoteDataSource {
  Future<List<EventModel>> getMyEvents();

  Future<EventModel> createEvent(CreateEventRequestModel request);
  Future<EventModel> updateEvent(int eventId, CreateEventRequestModel request);
  Future<void> deleteEvent(int eventId);
  Future<List<String>> getPreviousVenues();
}

class OrganizerRemoteDataSourceImpl implements OrganizerRemoteDataSource {
  final ApiClient apiClient;
  static const String _controllerPath = '/organizer/events';

  OrganizerRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<EventModel>> getMyEvents() async {
    final response = await apiClient.get('/events/my');

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final List<dynamic> decoded = jsonDecode(body);
      return decoded.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw ApiException(
        message: 'errorLoadingEvents',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<EventModel> createEvent(CreateEventRequestModel requestModel) async {
    final response = await apiClient.multipartRequest(
      method: 'POST',
      path: _controllerPath,
      jsonBody: requestModel.toJson(),
      jsonFieldName: 'event',
      file: requestModel.posterImage,
      fileFieldName: 'poster',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = utf8.decode(response.bodyBytes);
      return EventModel.fromJson(jsonDecode(body));
    } else {
      throw ApiException(
        message: 'errorCreatingEvent',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<EventModel> updateEvent(
    int eventId,
    CreateEventRequestModel requestModel,
  ) async {
    final response = await apiClient.multipartRequest(
      method: 'PUT',
      path: '$_controllerPath/$eventId',
      jsonBody: requestModel.toJson(),
      jsonFieldName: 'event',
      file: requestModel.posterImage,
      fileFieldName: 'poster',
    );

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      return EventModel.fromJson(jsonDecode(body));
    } else {
      throw ApiException(
        message: 'errorUpdatingEvent',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    final response = await apiClient.delete('$_controllerPath/$eventId');
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw ApiException(
        message: 'errorDeletingEvent',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<List<String>> getPreviousVenues() async {
    final response = await apiClient.get('$_controllerPath/places');

    if (response.statusCode == 200) {
      final body = utf8.decode(response.bodyBytes);
      final List<dynamic> decoded = jsonDecode(body);
      return decoded.map((e) => e.toString()).toList();
    } else {
      throw ApiException(
        message: 'errorLoadingVenues',
        statusCode: response.statusCode,
      );
    }
  }
}
