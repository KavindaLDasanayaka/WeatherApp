import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();

  Weather? _weather;

  //fetch weatheer by weather service
  void _fetchWeatherData() async {
    final weather = await _weatherService.getWeatherByLocation();
    setState(() {
      _weather = weather;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: _weather != null
          ? Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(_weather!.cityName),
                    Text(_weather!.condition),
                    Text(_weather!.description),
                    Text(_weather!.humidity.toString()),
                    Text(_weather!.pressure.toString()),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
