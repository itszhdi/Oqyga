import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';

abstract class PasswordResetRepository {
  Future<Either<Failure, void>> requestOtp(String phoneNumber);

  // Возвращает токен для сброса пароля в случае успеха
  Future<Either<Failure, String>> validateOtp(String otp);

  Future<Either<Failure, void>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}
