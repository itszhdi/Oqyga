import 'package:equatable/equatable.dart';

class ProfileUpdateRequest extends Equatable {
  final String? userName;
  final String? phoneNumber;
  final String? email;
  final String? userPhoto;

  const ProfileUpdateRequest({
    this.userName,
    this.phoneNumber,
    this.email,
    this.userPhoto,
  });

  @override
  List<Object?> get props => [userName, phoneNumber, email, userPhoto];
}
