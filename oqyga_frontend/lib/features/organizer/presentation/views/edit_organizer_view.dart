import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/user/domain/entities/profile_update_request.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';
import 'package:oqyga_frontend/features/user/presentation/widgets/text_field.dart';
import 'package:oqyga_frontend/features/user/presentation/widgets/user_avatar.dart';

class EditProfileOrganizerView extends StatefulWidget {
  const EditProfileOrganizerView({super.key});

  @override
  State<EditProfileOrganizerView> createState() =>
      _EditProfileOrganizerViewState();
}

class _EditProfileOrganizerViewState extends State<EditProfileOrganizerView> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  File? _newProfileImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileBloc>().state.userProfile;
    nameController.text = user.userName;
    phoneController.text = user.phoneNumber ?? '';
    emailController.text = user.email ?? '';
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (image != null && mounted) {
      setState(() => _newProfileImageFile = File(image.path));
    }
  }

  void _saveProfile() {
    final bloc = context.read<ProfileBloc>();

    if (_newProfileImageFile != null) {
      bloc.add(ProfilePhotoChanged(_newProfileImageFile!));
    }

    final updateRequest = ProfileUpdateRequest(
      userName: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
    );
    bloc.add(
      ProfileInfoUpdated(
        request: updateRequest,
        newPhoto: _newProfileImageFile,
      ),
    );

    final newPass = newPasswordController.text.trim();
    final currentPass = currentPasswordController.text.trim();
    if (newPass.isNotEmpty && currentPass.isNotEmpty) {
      bloc.add(
        ProfilePasswordChanged(
          currentPassword: currentPass,
          newPassword: newPass,
          confirmNewPassword: confirmPasswordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.failure ||
            state.status == ProfileStatus.success) {
          if (state.message.isNotEmpty) {
            final message = translateErrorMessage(context, state.message);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: state.status == ProfileStatus.success
                      ? Colors.green
                      : Colors.red,
                ),
              );
          }
        }
        // Используем ключ успеха из .arb
        if (state.status == ProfileStatus.success &&
            state.message == 'profileUpdatedSuccess') {
          context.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final isSaving = state.status == ProfileStatus.updating;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShadowedBackButton(onPressed: () => context.pop()),
                        const SizedBox(width: 16),
                        Text(
                          s.editProfileTitle,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: EditableUserAvatar(
                        currentPhotoUrl: state.userProfile.fullPhotoUrl,
                        newPhotoFile: _newProfileImageFile,
                        onAddPhoto: _pickImage,
                        isEnabled: !isSaving,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      s.yourOrganizationTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      controller: nameController,
                      labelText: s.organizationNameLabel,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      controller: phoneController,
                      labelText: s.phoneLabel,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      controller: emailController,
                      labelText: s.emailLabel,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      s.changePasswordTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileTextField(
                      controller: currentPasswordController,
                      labelText: s.currentPasswordLabel,
                      obscureText: true,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      controller: newPasswordController,
                      labelText: s.newPasswordLabel,
                      obscureText: true,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 12),
                    ProfileTextField(
                      controller: confirmPasswordController,
                      labelText: s.confirmPasswordLabel,
                      obscureText: true,
                      enabled: !isSaving,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: isSaving ? null : _saveProfile,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: isSaving
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              )
                            : Text(
                                s.saveButton,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
