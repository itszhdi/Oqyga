import 'dart:async';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/models/user_model.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';
import 'package:oqyga_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final _controller = StreamController<User>();

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<User> get user async* {
    yield* _controller.stream;
  }

  @override
  Future<void> checkInitialAuthStatus() async {
    final accessToken = await localDataSource.getAccessToken();
    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      _controller.add(UserModel.fromToken(accessToken));
    } else {
      _controller.add(User.empty);
    }
  }

  @override
  Future<void> signIn({required String name, required String password}) async {
    try {
      final tokens = await remoteDataSource.signIn(
        name: name,
        password: password,
      );
      await localDataSource.saveTokens(tokens);
      final user = UserModel.fromToken(tokens.accessToken);
      _controller.add(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String password,
    required String phone,
  }) async {
    try {
      final tokens = await remoteDataSource.signUp(
        name: name,
        password: password,
        phone: phone,
      );
      await localDataSource.saveTokens(tokens);
      final user = UserModel.fromToken(tokens.accessToken);
      _controller.add(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await localDataSource.deleteTokens();
    _controller.add(User.empty);
  }
}
