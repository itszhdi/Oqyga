import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/languages/presentation/bloc/language_bloc.dart';
import 'package:oqyga_frontend/features/languages/presentation/views/choose_language_view.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';
import 'package:oqyga_frontend/features/user/presentation/widgets/logout_confirm.dart';
import 'package:oqyga_frontend/features/user/presentation/widgets/text_field.dart';
import 'package:oqyga_frontend/features/user/presentation/widgets/user_avatar.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class ProfileOrganizerView extends StatelessWidget {
  const ProfileOrganizerView({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await LogoutConfirmationDialog.show(context);
    if (shouldLogout == true && context.mounted) {
      context.read<AuthBloc>().add(SignOutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.failure) {
              final message = translateErrorMessage(context, state.message);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.black,
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state.status == ProfileStatus.loading ||
                state.status == ProfileStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = state.userProfile;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 16),
                    child: Text(
                      s.organizerTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: UserAvatar(photoUrl: user.fullPhotoUrl, size: 100),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.yourOrganizationTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.goNamed('edit-profile-organizer'),
                        icon: const Icon(Icons.edit_road_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ProfileInfoField(
                    label: s.organizationNameLabel,
                    value: user.userName,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoField(
                    label: s.phoneLabel,
                    value: user.phoneNumber ?? s.notSpecified,
                  ),
                  const SizedBox(height: 15),
                  ProfileInfoField(
                    label: s.emailLabel,
                    value: user.email ?? s.notSpecified,
                  ),

                  // Раздел "Язык приложения"
                  const SizedBox(height: 30),
                  Text(
                    s.appLanguageTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, languageState) {
                      final currentCode =
                          languageState.locale?.languageCode ??
                          Localizations.localeOf(context).languageCode;

                      return ProfileNavigationField(
                        text: getLanguageName(currentCode),
                        onTap: () {
                          context.pushNamed('language');
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () => _handleLogout(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        s.logoutButton,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
