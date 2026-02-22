import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/organizer_events/organizer_events_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/views/organizer_events_view.dart';

class OrganizerEventsPage extends StatelessWidget {
  const OrganizerEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<OrganizerEventsBloc>()..add(FetchOrganizerEvents()),
      child: const OrganizerEventsView(),
    );
  }
}
