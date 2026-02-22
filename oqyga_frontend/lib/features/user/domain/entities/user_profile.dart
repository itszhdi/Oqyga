import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/core/constants/app_constants.dart';

class UserProfile extends Equatable {
  final int id;
  final String userName;
  final String? email;
  final String? phoneNumber;
  final String? userPhoto;

  static const _baseUrl = API;

  const UserProfile({
    required this.id,
    required this.userName,
    this.email,
    this.phoneNumber,
    this.userPhoto,
  });

  UserProfile copyWith({
    int? id,
    String? userName,
    String? email,
    String? phoneNumber,
    String? userPhoto,
  }) {
    return UserProfile(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userPhoto: userPhoto ?? this.userPhoto,
    );
  }

  static const empty = UserProfile(id: 0, userName: '');

  String? get fullPhotoUrl {
    if (userPhoto == null || userPhoto!.isEmpty) return null;
    if (userPhoto!.startsWith('http')) return userPhoto;
    return '$_baseUrl$userPhoto';
  }

  @override
  List<Object?> get props => [id, userName, email, phoneNumber, userPhoto];
}
