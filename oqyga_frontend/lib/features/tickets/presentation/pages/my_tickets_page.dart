import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/my_tickets/my_tickets_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/my_tickets_view.dart';

class MyTicketsPage extends StatelessWidget {
  const MyTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MyTicketsBloc>()..add(FetchMyTickets()),
      child: const MyTicketsView(),
    );
  }
}