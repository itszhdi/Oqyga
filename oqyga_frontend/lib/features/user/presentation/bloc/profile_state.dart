part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure, updating }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfile userProfile;
  final String message;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userProfile = UserProfile.empty,
    this.message = '',
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfile? userProfile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, userProfile, message];
}
