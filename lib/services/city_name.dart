import 'package:flutter_weather/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  static Future<Map<String, double>> fetchCityInfo(String cityName) async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl?name=$cityName');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['results'] != null &&
            jsonResponse['results'].isNotEmpty) {
          final location = jsonResponse['results'][0];
          return {
            'latitude': location['latitude'],
            'longitude': location['longitude'],
          };
        } else {
          throw Exception('No results found');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<WeatherData> fetchWeatherData(
      double latitude, double longitude) async {
    final baseUrl = dotenv.env['API_CITY_URL'];
    final urlParameters = dotenv.env['API_WEATHER_PARAMETERS'];
    final url = Uri.parse(
        '$baseUrl?latitude=$latitude&longitude=$longitude&$urlParameters');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
