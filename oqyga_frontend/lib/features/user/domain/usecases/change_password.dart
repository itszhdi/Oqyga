import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';

class ChangePassword {
  final UserProfileRepository repository;

  ChangePassword(this.repository);

  Future<Either<Failure, void>> call({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}
