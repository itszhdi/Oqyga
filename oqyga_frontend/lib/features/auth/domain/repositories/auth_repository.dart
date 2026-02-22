import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Stream<User> get user;
  Future<void> signIn({required String name, required String password});
  Future<void> signUp({
    required String name,
    required String password,
    required String phone,
  });
  Future<void> signOut();
  Future<void> checkInitialAuthStatus();
}
