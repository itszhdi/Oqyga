import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';
import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();

  Future<Either<Failure, UserProfile>> updateUserProfile(
    ProfileUpdateRequest request,
  );

  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<Either<Failure, String>> uploadProfilePhoto(File imageFile);
}
