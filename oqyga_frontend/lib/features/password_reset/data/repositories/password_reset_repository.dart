import 'package:dartz/dartz.dart';
import 'package:oqyga_frontend/core/errors/failure.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/password_reset/data/datasources/password_reset_remote_data_source.dart';
import 'package:oqyga_frontend/features/password_reset/domain/repositories/password_reset_repository.dart';

class PasswordResetRepositoryImpl implements PasswordResetRepository {
  final PasswordResetRemoteDataSource remoteDataSource;

  PasswordResetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> requestOtp(String phoneNumber) async {
    try {
      await remoteDataSource.requestOtp(phoneNumber);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> validateOtp(String otp) async {
    try {
      final token = await remoteDataSource.validateOtp(otp);
      return Right(token);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        resetToken: resetToken,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
