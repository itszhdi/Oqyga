import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oqyga_frontend/core/constants/app_constants.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';

abstract class PasswordResetRemoteDataSource {
  Future<void> requestOtp(String phoneNumber);
  Future<String> validateOtp(String otp);
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}

class PasswordResetRemoteDataSourceImpl
    implements PasswordResetRemoteDataSource {
  final http.Client client;
  static const String _apiBaseUrl = API;
  static const String _apiPrefix = "/api/v1";
  static const String _resetPath = "/auth/password-reset";

  PasswordResetRemoteDataSourceImpl({required this.client});

  Uri _buildUrl(String path) =>
      Uri.parse("$_apiBaseUrl$_apiPrefix$_resetPath$path");

  @override
  Future<void> requestOtp(String phoneNumber) async {
    final response = await client.post(
      _buildUrl("/request-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );
    if (response.statusCode != 200) {
      final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
      throw ApiException(
        message: errorBody['error'] ?? 'failedToSendOtp',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> validateOtp(String otp) async {
    final response = await client.post(
      _buildUrl("/validate-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'otp': otp}),
    );
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return body['passwordResetToken'];
    } else {
      throw ApiException(
        message: body['error'] ?? 'invalidOtp',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await client.post(
      _buildUrl("/reset-password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'passwordResetToken': resetToken,
        'newPassword': newPassword,
        'confirmNewPassword': confirmPassword,
      }),
    );
    if (response.statusCode != 200) {
      final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
      throw ApiException(
        message: errorBody['error'] ?? 'failedToResetPassword',
        statusCode: response.statusCode,
      );
    }
  }
}
