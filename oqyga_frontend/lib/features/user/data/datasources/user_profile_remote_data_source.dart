import 'dart:convert';
import 'dart:io';
import 'package:oqyga_frontend/core/api/api_client.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/user/data/models/profile_update_request_model.dart';
import 'package:oqyga_frontend/features/user/data/models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<UserProfileModel> updateUserProfile(ProfileUpdateRequestModel request);
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
  Future<String> uploadProfilePhoto(File imageFile);
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiClient apiClient;
  static const _profileMePath = "/profile/me";
  static const _profileUpdatePath = "/profile/update";
  static const _passwordChangePath = "/profile/change-password";
  static const _userPhotosPath = "/profile/upload-photo";

  UserProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserProfileModel> getUserProfile() async {
    final response = await apiClient.get(_profileMePath);
    if (response.statusCode == 200) {
      final jsonBody = utf8.decode(response.bodyBytes);
      return UserProfileModel.fromJson(jsonDecode(jsonBody));
    } else {
      throw ApiException(
        message: "errorLoadingProfile",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<UserProfileModel> updateUserProfile(
    ProfileUpdateRequestModel request,
  ) async {
    final response = await apiClient.put(
      _profileUpdatePath,
      body: jsonEncode(request.toJson()),
    );
    if (response.statusCode == 200) {
      final jsonBody = utf8.decode(response.bodyBytes);
      return UserProfileModel.fromJson(jsonDecode(jsonBody));
    } else {
      throw ApiException(
        message: "errorUpdatingProfile",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final response = await apiClient.post(
      _passwordChangePath,
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      }),
    );
    if (response.statusCode != 200) {
      throw ApiException(
        message: "errorChangingPassword",
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<String> uploadProfilePhoto(File imageFile) async {
    final response = await apiClient.postMultipart(
      _userPhotosPath,
      file: imageFile,
      fileField: 'file',
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse['userPhoto'] as String;
    } else {
      throw ApiException(
        message: "errorUploadingPhoto",
        statusCode: response.statusCode,
      );
    }
  }
}
