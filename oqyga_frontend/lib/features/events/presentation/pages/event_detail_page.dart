import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_detail/event_detail_bloc.dart';
import 'package:oqyga_frontend/features/events/presentation/views/event_detail_view.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class EventDetailPage extends StatelessWidget {
  final String eventId;
  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final id = int.tryParse(eventId);
    if (id == null) {
      return Scaffold(body: Center(child: Text(s.invalidEventId)));
    }

    return BlocProvider(
      create: (context) => sl<EventDetailBloc>()..add(FetchEventById(id)),
      child: const EventDetailView(),
    );
  }
}
