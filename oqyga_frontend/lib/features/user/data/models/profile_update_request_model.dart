import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';

class ProfileUpdateRequestModel extends ProfileUpdateRequest {
  const ProfileUpdateRequestModel({
    super.userName,
    super.phoneNumber,
    super.email,
    super.userPhoto,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'phoneNumber': phoneNumber,
    'email': email,
    'userPhoto': userPhoto,
  };
}
