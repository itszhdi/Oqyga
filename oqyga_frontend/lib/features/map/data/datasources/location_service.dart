import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Location?> getCoordinatesFromAddress(String city, String address) async {
    try {
      final String fullAddress = "$address, $city";
      
      List<Location> locations = await locationFromAddress(fullAddress);
      
      if (locations.isNotEmpty) {
        
        return locations.first;
      }
      return null;
    } catch (e) {
      print("Ошибка геокодирования для адреса $address: $e");
      return null;
    }
  }

  /// Определяет текущий город пользователя по GPS
  Future<String?> getCurrentCity() async {
    try {
      // Проверка разрешений на использование геолокации
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      // Получаем координаты устройства
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low 
      );

      // Превращаем координаты в название объекта (города)
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, 
        position.longitude
      );

      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
      return null;
    } catch (e) {
      print("Ошибка определения города: $e");
      return null;
    }
  }
}