import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import '../providers/recent_searches_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weatherData;
  bool _isLoading = false;
  String _errorMessage = '';

  void _fetchWeatherByCity(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather = await _weatherService.getWeatherByCity(cityName);
      setState(() {
        _weatherData = weather;
        _isLoading = false;
      });

      // Save to recent searches
      Provider.of<RecentSearchesProvider>(context, listen: false)
          .addSearch(cityName);
    } catch (e) {
      setState(() {
        _errorMessage = 'Şehir bulunamadı';
        _isLoading = false;
      });
    }
  }

  void _fetchWeatherByLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weather = await _weatherService.getWeatherByLocation();
      setState(() {
        _weatherData = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.white),
            onPressed: _fetchWeatherByLocation,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: 60,
                  borderRadius: 15,
                  blur: 20,
                  alignment: Alignment.center,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                  child: TextField(
                    controller: _cityController,
                    style: GoogleFonts.roboto(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Şehir adı girin',
                      hintStyle: GoogleFonts.roboto(color: Colors.white54),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () =>
                            _fetchWeatherByCity(_cityController.text),
                      ),
                    ),
                  ),
                ),
              ),

              // Recent Searches
              Consumer<RecentSearchesProvider>(
                builder: (context, recentSearches, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: recentSearches.recentSearches
                          .map((city) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ChoiceChip(
                                  label:
                                      Text(city, style: GoogleFonts.roboto()),
                                  selected: false,
                                  onSelected: (_) => _fetchWeatherByCity(city),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                },
              ),

              // Weather Display
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : _errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              _errorMessage,
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 18),
                            ),
                          )
                        : _weatherData != null
                            ? _WeatherDetailsCard(weather: _weatherData!)
                            : Center(
                                child: Text(
                                  'Bir şehir arayın',
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherDetailsCard extends StatelessWidget {
  final WeatherModel weather;

  const _WeatherDetailsCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.6,
      borderRadius: 20,
      blur: 20,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.2),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weather.cityName,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              'http://openweathermap.org/img/wn/${weather.icon}@4x.png',
              width: 150,
              height: 150,
            ),
            Text(
              '${weather.temperature.round()}°C',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              weather.description.toUpperCase(),
              style: GoogleFonts.roboto(
                color: Colors.white70,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
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
        Icon(icon, color: Colors.white, size: 30),
        Text(
          label,
          style: GoogleFonts.roboto(color: Colors.white70),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
