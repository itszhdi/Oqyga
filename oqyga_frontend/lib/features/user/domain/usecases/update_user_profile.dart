import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';
import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';

class UpdateUserProfile {
  final UserProfileRepository repository;

  UpdateUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call(ProfileUpdateRequest request) {
    return repository.updateUserProfile(request);
  }
}
