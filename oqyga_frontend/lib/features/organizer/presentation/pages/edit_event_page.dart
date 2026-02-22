import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/event_form/event_form_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/views/event_form_view.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class EditEventPage extends StatelessWidget {
  final Event eventData;
  const EditEventPage({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocProvider(
      create: (context) => sl<EventFormBloc>()
        ..add(InitializeEventForm())
        ..add(LoadEventForEdit(eventData)),
      child: EventFormView(isEditMode: true, title: s.editEventTitle),
    );
  }
}
