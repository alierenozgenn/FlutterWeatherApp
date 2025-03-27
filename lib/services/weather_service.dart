import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';

class WeatherService {
  static const String apiKey = '6c614be9b155ab4c53859c2d7bf8ed34';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeatherByCity(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Şehir bulunamadı');
    }
  }

  Future<WeatherModel> getWeatherByLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Konum servisleri devre dışı');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Konum izni reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Konum izinleri kalıcı olarak reddedildi');
    }

    Position position = await Geolocator.getCurrentPosition();

    final response = await http.get(
      Uri.parse(
          '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Konum bilgisi alınamadı');
    }
  }
}
