part of 'map_bloc.dart';

enum MapStatus {
  initial,
  loading,
  success,
  failure,
  showCityDialog,
  showConfirmDialog,
}

class MapEventItem extends Equatable {
  final EventModel event;
  final LatLng coordinates;

  const MapEventItem({required this.event, required this.coordinates});

  @override
  List<Object> get props => [event, coordinates];
}

class MapState extends Equatable {
  final MapStatus status;
  final List<CityModel> cities;
  final CityModel? selectedCity;
  final CityModel? detectedCity;
  final List<MapEventItem> mapItems;
  final String errorMessage;

  const MapState({
    this.status = MapStatus.initial,
    this.cities = const [],
    this.selectedCity,
    this.detectedCity,
    this.mapItems = const [],
    this.errorMessage = '',
  });

  MapState copyWith({
    MapStatus? status,
    List<CityModel>? cities,
    CityModel? selectedCity,
    CityModel? detectedCity,
    List<MapEventItem>? mapItems,
    String? errorMessage,
  }) {
    return MapState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      detectedCity: detectedCity ?? this.detectedCity,
      mapItems: mapItems ?? this.mapItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    cities,
    selectedCity,
    detectedCity,
    mapItems,
    errorMessage,
  ];
}
