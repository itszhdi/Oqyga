import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/event_form/event_form_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/views/event_form_view.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => sl<EventFormBloc>()..add(InitializeEventForm()),
      child: EventFormView(isEditMode: false, title: s.addEventTitle),
    );
  }
}
