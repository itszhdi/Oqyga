import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oqyga_frontend/core/constants/app_constants.dart';
import 'package:oqyga_frontend/features/auth/data/models/auth_tokens_model.dart';

class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException({required this.message, required this.statusCode});
}

abstract class AuthRemoteDataSource {
  Future<AuthTokensModel> signIn({
    required String name,
    required String password,
  });
  Future<AuthTokensModel> signUp({
    required String name,
    required String password,
    required String phone,
  });
  Future<AuthTokensModel> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  static const String _apiBaseUrl = API;
  static const String _apiPrefix = "/api/v1";
  static const String _authPath = "/auth";

  AuthRemoteDataSourceImpl(this.client);

  Uri _buildUrl(String path) => Uri.parse("$_apiBaseUrl$_apiPrefix$path");

  @override
  Future<AuthTokensModel> signIn({
    required String name,
    required String password,
  }) async {
    final response = await client.post(
      _buildUrl("$_authPath/sign-in"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"userName": name, "password": password}),
    );

    if (response.statusCode == 200) {
      return AuthTokensModel.fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw ApiException(message: 'invalidCredentialsError', statusCode: 401);
    } else {
      String message = 'signInFailedError';
      try {
        final errorBody = jsonDecode(response.body);
        message = errorBody['message'] ?? message;
      } catch (_) {}
      throw ApiException(message: message, statusCode: response.statusCode);
    }
  }

  @override
  Future<AuthTokensModel> signUp({
    required String name,
    required String password,
    required String phone,
  }) async {
    final response = await client.post(
      _buildUrl("$_authPath/sign-up"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userName": name,
        "password": password,
        "phoneNumber": phone,
      }),
    );
    if (response.statusCode == 200) {
      return AuthTokensModel.fromJson(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw ApiException(
        message: errorBody['message'] ?? 'signUpFailedError',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    final response = await client.post(
      _buildUrl("$_authPath/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'refreshToken': refreshToken}),
    );
    if (response.statusCode == 200) {
      return AuthTokensModel.fromJson(response.body);
    } else {
      throw ApiException(
        // ИСПОЛЬЗУЕМ КЛЮЧ
        message: 'tokenRefreshFailedError',
        statusCode: response.statusCode,
      );
    }
  }
}
