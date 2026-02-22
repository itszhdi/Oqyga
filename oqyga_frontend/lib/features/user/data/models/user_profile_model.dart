import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.userName,
    super.email,
    super.phoneNumber,
    super.userPhoto,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['userId'] as int,
      userName: json['userName'] as String? ?? '',
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userPhoto: json['userPhoto'] as String?,
    );
  }
}
