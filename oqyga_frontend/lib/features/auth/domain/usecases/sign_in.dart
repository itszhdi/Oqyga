import 'package:oqyga_frontend/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<void> call({required String name, required String password}) {
    return repository.signIn(name: name, password: password);
  }
}