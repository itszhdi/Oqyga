import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_list/event_list_bloc.dart';
import 'package:oqyga_frontend/features/events/presentation/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventsListBloc>()..add(const FetchEvents()),
      child: const HomeView(),
    );
  }
}
