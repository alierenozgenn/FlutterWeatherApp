import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Image.network(
              'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
              width: 100,
              height: 100,
            ),
            Text(
              '${weather.temperature.round()}°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
            ),
            Text(
              weather.description.toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(
                  Icons.thermostat,
                  'Hissedilen',
                  '${weather.feelsLike.round()}°C',
                ),
                _buildDetailItem(
                  Icons.water_drop,
                  'Nem',
                  '${weather.humidity}%',
                ),
                _buildDetailItem(
                  Icons.wind_power,
                  'Rüzgar',
                  '${weather.windSpeed.round()} km/s',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
