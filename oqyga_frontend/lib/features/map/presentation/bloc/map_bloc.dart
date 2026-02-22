import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/events/data/models/event_model.dart';
import 'package:oqyga_frontend/features/filters/data/datasources/filter_remote_data_source.dart';
import 'package:oqyga_frontend/features/filters/data/models/city_model.dart';
import 'package:oqyga_frontend/features/map/data/datasources/map_remote_data_source.dart';
import 'package:oqyga_frontend/features/map/data/services/location_service.dart';
import 'package:oqyga_frontend/shared/dialog_manager.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final FilterRemoteDataSource _filterDataSource;
  final MapRemoteDataSource _mapDataSource;
  final LocationService _locationService;
  final DialogManager _dialogManager;
  final AuthBloc _authBloc;

  MapBloc({
    required FilterRemoteDataSource filterDataSource,
    required MapRemoteDataSource mapDataSource,
    required LocationService locationService,
    required DialogManager dialogManager,
    required AuthBloc authBloc,
  }) : _filterDataSource = filterDataSource,
       _mapDataSource = mapDataSource,
       _locationService = locationService,
       _dialogManager = dialogManager,
       _authBloc = authBloc,
       super(const MapState()) {
    on<MapInitializeEvent>(_onInitialize);
    on<MapCitySelectedEvent>(_onCitySelected);
    on<MapLanguageChangedEvent>(_onLanguageChanged);
  }

  Future<void> _onInitialize(
    MapInitializeEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: MapStatus.loading));
    try {
      final userId = _authBloc.state.user.id;
      final cities = await _filterDataSource.getCities(event.languageCode);

      emit(state.copyWith(cities: cities));

      final bool needShow = await _dialogManager.shouldShowCityDialog(userId);

      if (!needShow) {
        if (cities.isNotEmpty) {
          add(
            MapCitySelectedEvent(
              city: cities.first,
              languageCode: event.languageCode,
            ),
          );
        }
        return;
      }

      final String? detectedCityName = await _locationService.getCurrentCity();
      CityModel? matchedCity;

      if (detectedCityName != null && cities.isNotEmpty) {
        matchedCity = cities.firstWhere(
          (c) => c.cityName.toLowerCase() == detectedCityName.toLowerCase(),
          orElse: () => cities.first,
        );
      }

      if (matchedCity != null) {
        emit(
          state.copyWith(
            status: MapStatus.showConfirmDialog,
            detectedCity: matchedCity,
          ),
        );
      } else {
        emit(state.copyWith(status: MapStatus.showCityDialog));
      }
    } catch (e) {
      emit(
        state.copyWith(status: MapStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onCitySelected(
    MapCitySelectedEvent event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: MapStatus.loading, selectedCity: event.city));

    final userId = _authBloc.state.user.id;
    _dialogManager.markCityDialogAsShown(userId);

    try {
      final events = await _mapDataSource.getEventsByCity(
        event.city.cityId,
        event.languageCode,
      );

      final List<MapEventItem> items = [];

      // Геокодинг лучше делать в BloC, чтобы View была глупой
      // ПРИМЕЧАНИЕ: В реальном проекте лучше делать это параллельно или кешировать
      for (var evt in events) {
        final coords = await _locationService.getCoordinatesFromAddress(
          event.city.cityName,
          evt.address,
        );
        if (coords != null) {
          items.add(MapEventItem(event: evt, coordinates: coords));
        }
      }

      emit(state.copyWith(status: MapStatus.success, mapItems: items));
    } catch (e) {
      emit(
        state.copyWith(status: MapStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onLanguageChanged(
    MapLanguageChangedEvent event,
    Emitter<MapState> emit,
  ) async {
    // При смене языка перезагружаем города и события для текущего города
    if (state.selectedCity != null) {
      // Сначала обновляем список городов на новом языке (опционально, если названия городов меняются)
      try {
        final cities = await _filterDataSource.getCities(event.languageCode);
        final newSelectedCity = cities.firstWhere(
          (c) => c.cityId == state.selectedCity!.cityId,
          orElse: () => cities.first,
        );

        emit(state.copyWith(cities: cities));
        add(
          MapCitySelectedEvent(
            city: newSelectedCity,
            languageCode: event.languageCode,
          ),
        );
      } catch (e) {
        // Fallback
        add(
          MapCitySelectedEvent(
            city: state.selectedCity!,
            languageCode: event.languageCode,
          ),
        );
      }
    } else {
      add(MapInitializeEvent(event.languageCode));
    }
  }
}
