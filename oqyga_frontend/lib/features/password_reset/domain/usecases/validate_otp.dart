import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/password_reset/domain/repositories/password_reset_repository.dart';

class ValidateOtp {
  final PasswordResetRepository repository;

  ValidateOtp(this.repository);

  Future<Either<Failure, String>> call(String otp) {
    return repository.validateOtp(otp);
  }
}
