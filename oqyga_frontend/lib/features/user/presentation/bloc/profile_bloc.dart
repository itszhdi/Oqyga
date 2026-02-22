import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';
import 'package:oqyga_frontend/features/user/domain/entities/user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/change_password.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/get_user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/update_user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/upload_profile_photo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfile _getUserProfile;
  final UpdateUserProfile _updateUserProfile;
  final ChangePassword _changePassword;
  final UploadProfilePhoto _uploadProfilePhoto;

  ProfileBloc({
    required GetUserProfile getUserProfile,
    required UpdateUserProfile updateUserProfile,
    required ChangePassword changePassword,
    required UploadProfilePhoto uploadProfilePhoto,
  }) : _getUserProfile = getUserProfile,
       _updateUserProfile = updateUserProfile,
       _changePassword = changePassword,
       _uploadProfilePhoto = uploadProfilePhoto,
       super(const ProfileState()) {
    on<ProfileFetched>(_onProfileFetched);
    on<ProfilePhotoChanged>(_onProfilePhotoChanged);
    on<ProfileInfoUpdated>(_onProfileInfoUpdated);
    on<ProfilePasswordChanged>(_onProfilePasswordChanged);
  }

  Future<void> _onProfileFetched(
    ProfileFetched event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _getUserProfile();
    result.fold(
      (failure) => emit(
        state.copyWith(status: ProfileStatus.failure, message: failure.message),
      ),
      (userProfile) => emit(
        state.copyWith(status: ProfileStatus.success, userProfile: userProfile),
      ),
    );
  }

  Future<void> _onProfilePhotoChanged(
    ProfilePhotoChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(status: ProfileStatus.updating, message: 'uploadingPhoto'),
    );
    final result = await _uploadProfilePhoto(event.photo);

    result.fold(
      (failure) => emit(
        state.copyWith(status: ProfileStatus.failure, message: failure.message),
      ),
      (photoPath) {
        final updatedProfile = state.userProfile.copyWith(userPhoto: photoPath);

        emit(
          state.copyWith(
            status: ProfileStatus.success,
            userProfile: updatedProfile,
            message: 'photoUpdatedSuccess',
          ),
        );
      },
    );
  }

  Future<void> _onProfileInfoUpdated(
    ProfileInfoUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(status: ProfileStatus.updating, message: 'savingChanges'),
    );

    if (event.newPhoto != null) {
      final photoResult = await _uploadProfilePhoto(event.newPhoto!);

      final photoError = photoResult.fold((l) => l, (r) => null);
      if (photoError != null) {
        emit(
          state.copyWith(
            status: ProfileStatus.failure,

            message: 'errorUploadingPhoto',
          ),
        );
        return;
      }
    }

    final result = await _updateUserProfile(event.request);

    result.fold(
      (failure) => emit(
        state.copyWith(status: ProfileStatus.failure, message: failure.message),
      ),
      (updatedProfile) {
        emit(
          state.copyWith(
            status: ProfileStatus.success,
            userProfile: updatedProfile,
            message: 'profileUpdatedSuccess',
          ),
        );
      },
    );
  }

  Future<void> _onProfilePasswordChanged(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProfileStatus.updating,
        message: 'changingPassword',
      ),
    );
    final result = await _changePassword(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
      confirmNewPassword: event.confirmNewPassword,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: ProfileStatus.failure, message: failure.message),
      ),
      (_) => emit(
        state.copyWith(
          status: ProfileStatus.success,
          message: 'passwordChangedSuccess',
        ),
      ),
    );
  }
}
