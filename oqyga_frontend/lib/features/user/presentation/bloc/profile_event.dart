part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileFetched extends ProfileEvent {}

class ProfileInfoUpdated extends ProfileEvent {
  final ProfileUpdateRequest request;
  final File? newPhoto;

  const ProfileInfoUpdated({required this.request, this.newPhoto});

  @override
  List<Object?> get props => [request, newPhoto];
}

class ProfilePhotoChanged extends ProfileEvent {
  final File photo;
  const ProfilePhotoChanged(this.photo);

  @override
  List<Object> get props => [photo];
}

class ProfilePasswordChanged extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  const ProfilePasswordChanged({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword, confirmNewPassword];
}
