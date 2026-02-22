import 'dart:convert';
import 'package:oqyga_frontend/features/auth/domain/entities/auth_tokens.dart';

class AuthTokensModel extends AuthTokens {
  const AuthTokensModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthTokensModel.fromJson(String source) {
    final map = json.decode(source) as Map<String, dynamic>;
    return AuthTokensModel(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }
}
