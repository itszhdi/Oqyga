import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';
import 'package:oqyga_frontend/features/filters/presentation/bloc/filter_bloc.dart';
import 'package:oqyga_frontend/features/filters/presentation/views/event_filters_view.dart';

class EventFiltersPage extends StatelessWidget {
  final EventFilters? initialFilters;
  const EventFiltersPage({super.key, this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FilterBloc>()..add(LoadFilterOptions()),
      child: EventFiltersView(initialFilters: initialFilters),
    );
  }
}
