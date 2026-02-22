import 'dart:convert';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/filters/data/models/age_restriction_model.dart';
import 'package:oqyga_frontend/features/filters/data/models/category_model.dart';
import 'package:oqyga_frontend/features/filters/data/models/city_model.dart';

abstract class FilterRemoteDataSource {
  // Добавляем languageCode во все методы
  Future<List<CityModel>> getCities(String languageCode);
  Future<List<CategoryModel>> getCategories(String languageCode);
  Future<List<AgeRestrictionModel>> getAgeRestrictions();
}

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  final ApiClient apiClient;
  static const String baseUrl = '/filter';

  FilterRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<CityModel>> getCities(String languageCode) async {
    try {
      final response = await apiClient.get(
        '$baseUrl/cities',
        headers: {'Accept-Language': languageCode},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(
          utf8.decode(response.bodyBytes),
        );
        return jsonData.map((json) => CityModel.fromJson(json)).toList();
      } else {
        throw ApiException(
          message: "failedToLoadCities",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: "failedToLoadCities", statusCode: 500);
    }
  }

  @override
  Future<List<CategoryModel>> getCategories(String languageCode) async {
    try {
      final response = await apiClient.get(
        '$baseUrl/categories',
        headers: {'Accept-Language': languageCode},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(
          utf8.decode(response.bodyBytes),
        );
        return jsonData.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw ApiException(
          message: "failedToLoadCategories",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: "failedToLoadCategories", statusCode: 500);
    }
  }

  @override
  Future<List<AgeRestrictionModel>> getAgeRestrictions() async {
    try {
      final response = await apiClient.get('$baseUrl/age-restrictions');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(
          utf8.decode(response.bodyBytes),
        );
        return jsonData
            .map((json) => AgeRestrictionModel.fromJson(json))
            .toList();
      } else {
        throw ApiException(
          message: "failedToLoadAgeRestrictions",
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        message: "failedToLoadAgeRestrictions",
        statusCode: 500,
      );
    }
  }
}
