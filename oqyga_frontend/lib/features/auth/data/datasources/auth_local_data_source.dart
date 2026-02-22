import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/auth_tokens.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class AuthLocalDataSource {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens(AuthTokens tokens);
  Future<void> deleteTokens();
  Future<int?> getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _storage;
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  AuthLocalDataSourceImpl(this._storage);

  @override
  Future<void> deleteTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  @override
  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  @override
  Future<void> saveTokens(AuthTokens tokens) async {
    await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  @override
  Future<int?> getUserId() async {
    final token = await getAccessToken();

    if (token == null) {
      return null;
    }

    try {
      Map<String, dynamic> payload = JwtDecoder.decode(token);

      dynamic rawId;

      if (payload.containsKey('id')) {
        rawId = payload['id'];
      } else if (payload.containsKey('userId')) {
        rawId = payload['userId'];
      } else if (payload.containsKey('user_id')) {
        rawId = payload['user_id'];
      } else if (payload.containsKey('sub')) {
        rawId = payload['sub'];
      } else if (payload.containsKey('uid')) {
        rawId = payload['uid'];
      }

      if (rawId is int) {
        return rawId;
      } else if (rawId is String) {
        return int.tryParse(rawId);
      } else if (rawId is double) {
        return rawId.toInt();
      }
    } catch (e) {}

    return null;
  }
}
