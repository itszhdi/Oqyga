import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/views/organizer_profile_view.dart';

class ProfileOrganizerPage extends StatelessWidget {
  const ProfileOrganizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ProfileBloc>()..add(ProfileFetched()),
      child: const ProfileOrganizerView(),
    );
  }
}
