import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';
import 'package:flutter_weather/services/city_name.dart';
import 'package:flutter_weather/widget/current_card.dart';
import 'package:flutter_weather/widget/day.dart';
import 'package:flutter_weather/widget/weather_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';
  Map<String, dynamic>? cityInfo;
  WeatherData? weatherData;

  void _openCitySearch() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WeatherTextField(
        onSubmitted: (value) async {
          //városnév frissítése
          setState(() {
            city = value;
          });
          Navigator.of(context).pop();
          try {
            cityInfo = await WeatherApiService.fetchCityInfo(city);
            if (cityInfo != null) {
              weatherData = await WeatherApiService.fetchWeatherData(
                cityInfo!['latitude'],
                cityInfo!['longitude'],
              );
              //weatherData frissítése
              setState(() {});
            } else {
              print('No city information found for $city');
            }
          } catch (e) {
            print('Error retrieving city info: $e');
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.isEmpty ? 'City' : city),
        actions: [
          IconButton(
            onPressed: _openCitySearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: CustomCard(dateData: weatherData?.current,),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Day(dailyData: weatherData?.daily),
            ),
          ),
        ],
      ),
    );
  }
}
