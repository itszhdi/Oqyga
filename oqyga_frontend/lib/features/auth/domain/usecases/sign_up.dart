import 'package:oqyga_frontend/features/auth/domain/repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<void> call({
    required String name,
    required String password,
    required String phone,
  }) {
    return repository.signUp(name: name, password: password, phone: phone);
  }
}
