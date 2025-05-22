import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/services/get_location_service.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  //get weather by cityname
  Future<Weather> getWeatherByCityName(String cityName) async {
    try {
      https: //api.openweathermap.org/data/2.5/weather?q=London&appid=22beabefe0623bd63046bf8eb854988a&units=metric

      final String url = "$BASE_URL?q=$cityName&appid=$apiKey&units=metric";

      final responce = await http.get(Uri.parse(url));

      if (responce.statusCode == 200) {
        final weatherData = json.decode(responce.body);

        Weather weather = Weather.fromJson(weatherData);
        return weather;
      } else {
        throw Exception("Failed to get Weather");
      }
    } catch (err) {
      print("Get weather Error: $err");
      throw Exception("Failed to get weather by cityname");
    }
  }

  //get the weather from the location
  Future<Weather> getWeatherByLocation() async {
    final location = Location();
    final cityName = await location.getLocation();

    final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
