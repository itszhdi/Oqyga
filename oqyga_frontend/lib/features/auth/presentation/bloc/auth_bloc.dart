import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';
import 'package:oqyga_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_in.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_out.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required SignIn signIn,
    required SignUp signUp,
    required SignOut signOut,
  }) : _authRepository = authRepository,
       _signIn = signIn,
       _signUp = signUp,
       _signOut = signOut,
       super(const AuthState.unknown()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<_AuthUserChanged>(_onAuthUserChanged);

    _userSubscription = _authRepository.user.listen(
      (user) => add(_AuthUserChanged(user)),
    );
    _authRepository.checkInitialAuthStatus();
  }

  void _onAuthUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _signIn(name: event.name, password: event.password);
    } on ApiException catch (e) {
      emit(AuthState.error(e.message));
      emit(const AuthState.unauthenticated());
    } catch (_) {
      emit(const AuthState.error('unexpectedError'));
      emit(const AuthState.unauthenticated());
    }
  }

  void _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    try {
      await _signUp(
        name: event.name,
        password: event.password,
        phone: event.phone,
      );
    } on ApiException catch (e) {
      emit(AuthState.error(e.message));
      emit(const AuthState.unauthenticated());
    } catch (_) {
      emit(const AuthState.error('unexpectedError'));
      emit(const AuthState.unauthenticated());
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    unawaited(_signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
