import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/organizer_filters.dart';
import 'package:oqyga_frontend/features/filters/presentation/bloc/filter_bloc.dart';
import 'package:oqyga_frontend/features/filters/presentation/views/organizer_filters_view.dart';

class OrganizerFiltersPage extends StatelessWidget {
  final OrganizerFilters? initialFilters;
  const OrganizerFiltersPage({super.key, this.initialFilters});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FilterBloc>()..add(LoadFilterOptions()),
      child: OrganizerFiltersView(initialFilters: initialFilters),
    );
  }
}
