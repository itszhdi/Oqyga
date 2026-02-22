import 'package:equatable/equatable.dart';

enum UserRole { user, organisator }

class User extends Equatable {
  final int id;
  final String name;
  final UserRole role;

  const User({required this.id, required this.name, required this.role});

  static const empty = User(id: 0, name: 'user', role: UserRole.user);
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, role];
}
