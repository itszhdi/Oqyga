import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/user/data/datasources/user_profile_remote_data_source.dart';
import 'package:oqyga_frontend/features/user/data/models/profile_update_request_model.dart';
import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';
import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final userProfile = await remoteDataSource.getUserProfile();
      return Right(userProfile);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
    ProfileUpdateRequest request,
  ) async {
    try {
      final requestModel = ProfileUpdateRequestModel(
        userName: request.userName,
        email: request.email,
        phoneNumber: request.phoneNumber,
        userPhoto: request.userPhoto,
      );
      final updatedProfile = await remoteDataSource.updateUserProfile(
        requestModel,
      );
      return Right(updatedProfile);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto(File imageFile) async {
    try {
      final photoPath = await remoteDataSource.uploadProfilePhoto(imageFile);
      return Right(photoPath);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
