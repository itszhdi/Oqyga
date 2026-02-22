import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/core/constants/app_constants.dart';

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}

class ApiClient {
  final http.Client _client;
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  ApiClient({
    required http.Client client,
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  }) : _client = client,
       _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  bool _isRefreshing = false;

  static const String _apiBaseUrl = API;
  static const String _apiPrefix = "/api/v1";

  Uri _buildUrl(String path) => Uri.parse("$_apiBaseUrl$_apiPrefix$path");

  Future<http.Response> get(
    String path, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) {
      final url = _buildUrl(path).replace(queryParameters: queryParams);
      return _client.get(url, headers: requestHeaders);
    }, extraHeaders: headers);
  }

  Future<http.Response> post(
    String path, {
    required String body,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) {
      final url = _buildUrl(path);
      return _client.post(url, headers: requestHeaders, body: body);
    }, extraHeaders: headers);
  }

  Future<http.Response> put(
    String path, {
    required String body,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) {
      final url = _buildUrl(path);
      return _client.put(url, headers: requestHeaders, body: body);
    }, extraHeaders: headers);
  }

  Future<http.Response> delete(
    String path, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) {
      final url = _buildUrl(path).replace(queryParameters: queryParams);
      return _client.delete(url, headers: requestHeaders);
    }, extraHeaders: headers);
  }

  Future<http.Response> postMultipart(
    String path, {
    required File file,
    required String fileField,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) async {
      final url = _buildUrl(path);
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(requestHeaders)
        ..files.add(await http.MultipartFile.fromPath(fileField, file.path));

      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    }, extraHeaders: headers);
  }

  Future<http.Response> multipartRequest({
    required String method,
    required String path,
    required Map<String, dynamic> jsonBody,
    required String jsonFieldName,
    File? file,
    String? fileFieldName,
    Map<String, String>? headers,
  }) async {
    return _makeRequest((requestHeaders) async {
      final url = _buildUrl(path);
      final request = http.MultipartRequest(method, url);

      request.headers.addAll(requestHeaders);
      request.headers.remove('Content-Type');

      request.files.add(
        http.MultipartFile.fromString(
          jsonFieldName,
          jsonEncode(jsonBody),
          contentType: MediaType('application', 'json'),
        ),
      );

      if (file != null && fileFieldName != null) {
        final mimeType = MediaType('image', 'jpeg');
        request.files.add(
          await http.MultipartFile.fromPath(
            fileFieldName,
            file.path,
            contentType: mimeType,
          ),
        );
      }

      final streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    }, extraHeaders: headers);
  }

  Future<http.Response> _makeRequest(
    Future<http.Response> Function(Map<String, String> headers)
    requestBuilder, {
    Map<String, String>? extraHeaders,
  }) async {
    final accessToken = await _localDataSource.getAccessToken();
    if (accessToken == null) {
      throw AuthenticationException('Access token not found. Please log in.');
    }

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
      ...?extraHeaders,
    };

    http.Response response = await requestBuilder(headers);

    if (response.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        await _refreshToken();

        final newAccessToken = await _localDataSource.getAccessToken();

        final newHeaders = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $newAccessToken",
          ...?extraHeaders,
        };

        response = await requestBuilder(newHeaders);
      } catch (e) {
        throw AuthenticationException('Session expired. Please log in again.');
      } finally {
        _isRefreshing = false;
      }
    }
    return response;
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _localDataSource.getRefreshToken();
    if (refreshToken == null || JwtDecoder.isExpired(refreshToken)) {
      throw AuthenticationException('No valid refresh token available');
    }

    try {
      final newTokens = await _remoteDataSource.refreshToken(refreshToken);
      await _localDataSource.saveTokens(newTokens);
    } catch (e) {
      // Если API вернул ошибку при обновлении, значит сессия окончательно протухла
      await _localDataSource.deleteTokens(); // Очищаем старые токены
      rethrow;
    }
  }
}
