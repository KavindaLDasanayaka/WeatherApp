import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/widgets/display_weather.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherService _weatherService = WeatherService();

  Weather? _weather;

  String? _error;

  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _error = "Please enter city name!";
      });
    } else {
      try {
        final weather = await _weatherService.getWeatherByCityName(city);
        setState(() {
          _weather = weather;
        });
      } catch (err) {
        setState(() {
          _error = "Could not fetch weather data for $city";
          _weather = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Weather")),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "City Name",

                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _searchWeather,
                    icon: Icon(Icons.search),
                  ),
                ),
                onSubmitted: (value) => _searchWeather(),
              ),
              const SizedBox(height: 15),
              _error != null
                  ? Text(_error!, style: TextStyle(color: Colors.red))
                  : _weather != null
                  ? WeatherDisplay(weather: _weather!)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
