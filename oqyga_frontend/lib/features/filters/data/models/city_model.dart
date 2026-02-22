import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';

class CityModel extends City {
  const CityModel({required super.cityId, required super.cityName});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json['cityId'] as int,
      cityName: json['cityName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'cityId': cityId, 'cityName': cityName};
  }
}
