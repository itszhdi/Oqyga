import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/password_reset/domain/repositories/password_reset_repository.dart';

class ResetPassword {
  final PasswordResetRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, void>> call({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repository.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
