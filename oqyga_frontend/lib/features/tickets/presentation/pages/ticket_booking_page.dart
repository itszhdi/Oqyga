import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/ticket_booking_view.dart';

class TicketBookingPage extends StatelessWidget {
  final String eventId;
  final Event event;

  const TicketBookingPage({
    super.key,
    required this.eventId,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TicketPurchaseBloc>()..add(PurchaseFlowStarted(event)),
      child: const TicketBookingView(),
    );
  }
}
