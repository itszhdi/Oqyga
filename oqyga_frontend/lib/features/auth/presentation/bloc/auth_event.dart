part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class _AuthUserChanged extends AuthEvent {
  final User user;
  const _AuthUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class SignInRequested extends AuthEvent {
  final String name;
  final String password;

  const SignInRequested({required this.name, required this.password});

  @override
  List<Object> get props => [name, password];
}

class SignUpRequested extends AuthEvent {
  final String name;
  final String password;
  final String phone;

  const SignUpRequested({
    required this.name,
    required this.password,
    required this.phone,
  });

  @override
  List<Object> get props => [name, password, phone];
}

class SignOutRequested extends AuthEvent {}
