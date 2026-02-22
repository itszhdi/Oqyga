import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';

class GetUserProfile {
  final UserProfileRepository repository;

  GetUserProfile(this.repository);

  Future<Either<Failure, UserProfile>> call() {
    return repository.getUserProfile();
  }
}
