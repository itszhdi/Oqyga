import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';
import 'package:oqyga_frontend/features/user/presentation/views/profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ProfileBloc>()..add(ProfileFetched()),
      child: const ProfileView(),
    );
  }
}
