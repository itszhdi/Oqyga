import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int cityId;
  final String cityName;

  const City({required this.cityId, required this.cityName});

  @override
  List<Object> get props => [cityId, cityName];
}
