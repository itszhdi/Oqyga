import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_detail/ticket_detail_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/ticket_detail_view.dart';

class TicketDetailPage extends StatelessWidget {
  final String ticketId;

  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TicketDetailBloc>()..add(FetchTicketData(int.parse(ticketId))),
      child: const TicketDetailView(),
    );
  }
}
