import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.role,
  });

  factory UserModel.fromToken(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);
      return UserModel(
        id: int.tryParse(decodedToken['sub'].toString()) ?? 0,
        name: decodedToken['name'] ?? '',
        role: _roleFromString(decodedToken['role'] ?? 'USER'),
      );
    } catch (e) {
      return const UserModel(id: 0, name: 'user', role: UserRole.user);
    }
  }

  static UserRole _roleFromString(String roleString) {
    final cleanRole = roleString.toUpperCase().replaceFirst('ROLE_', '');
    switch (cleanRole) {
      case 'ORGANISATOR':
        return UserRole.organisator;
      case 'USER':
        return UserRole.user;
      default:
        return UserRole.user;
    }
  }
}
