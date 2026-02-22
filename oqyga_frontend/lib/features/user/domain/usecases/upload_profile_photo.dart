import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';

class UploadProfilePhoto {
  final UserProfileRepository repository;

  UploadProfilePhoto(this.repository);

  Future<Either<Failure, String>> call(File imageFile) {
    return repository.uploadProfilePhoto(imageFile);
  }
}
