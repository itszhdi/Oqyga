part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapInitializeEvent extends MapEvent {
  final String languageCode;
  const MapInitializeEvent(this.languageCode);
}

class MapCitySelectedEvent extends MapEvent {
  final CityModel city;
  final String languageCode;

  const MapCitySelectedEvent({required this.city, required this.languageCode});
}

class MapLanguageChangedEvent extends MapEvent {
  final String languageCode;
  const MapLanguageChangedEvent(this.languageCode);
}