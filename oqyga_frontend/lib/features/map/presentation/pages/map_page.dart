import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/filters/data/datasources/filter_remote_data_source.dart';
import 'package:oqyga_frontend/features/languages/presentation/bloc/language_bloc.dart';
import 'package:oqyga_frontend/features/map/data/datasources/map_remote_data_source.dart';
import 'package:oqyga_frontend/features/map/data/services/location_service.dart';
import 'package:oqyga_frontend/features/map/presentation/bloc/map_bloc.dart';
import 'package:oqyga_frontend/features/map/presentation/views/map_view.dart';
import 'package:oqyga_frontend/shared/dialog_manager.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final currentLang = Intl.getCurrentLocale().substring(0, 2);
        return MapBloc(
          filterDataSource: sl<FilterRemoteDataSource>(),
          mapDataSource: sl<MapRemoteDataSource>(),
          locationService: LocationService(),
          dialogManager: DialogManager(),
          authBloc: sl<AuthBloc>(),
        )..add(MapInitializeEvent(currentLang));
      },
      child: BlocListener<LanguageBloc, LanguageState>(
        listener: (context, state) {
          final newLang = state.locale?.languageCode;
          if (newLang != null) {
            context.read<MapBloc>().add(MapLanguageChangedEvent(newLang));
          }
        },
        child: const MapView(),
      ),
    );
  }
}
