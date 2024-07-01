import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  static Future<Map<String, double>> fetchCityInfo(String cityName) async {
    final baseUrl = dotenv.env['API_BASE_URL'];
    final endpoint = dotenv.env['API_ENDPOINT'];
    final url = Uri.parse('$baseUrl$endpoint?name=$cityName');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['results'] != null && jsonResponse['results'].isNotEmpty) {
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
}
