import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/views/edit_organizer_view.dart';

class EditProfileOrganizerPage extends StatelessWidget {
  const EditProfileOrganizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ProfileBloc>(),
      child: const EditProfileOrganizerView(),
    );
  }
}
