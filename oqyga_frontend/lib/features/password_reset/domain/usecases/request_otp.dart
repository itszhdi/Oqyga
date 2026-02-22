import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/password_reset/domain/repositories/password_reset_repository.dart';

class RequestOtp {
  final PasswordResetRepository repository;

  RequestOtp(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber) {
    return repository.requestOtp(phoneNumber);
  }
}
