import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';
import 'package:flutter_weather/services/city_name.dart';
import 'package:flutter_weather/widget/current_card.dart';
import 'package:flutter_weather/widget/day.dart';
import 'package:flutter_weather/widget/weather_text_field.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.city}) : super(key: key);

  late String city;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? cityInfo;
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  void _openCitySearch() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WeatherTextField(
        onSubmitted: (value) async {
          setState(() {
            widget.city =
                value; 
          });
          Navigator.of(ctx).pop();
          _fetchWeatherData(); 
        },
      ),
    );
  }

  void _fetchWeatherData() async {
    try {
      cityInfo = await WeatherApiService.fetchCityInfo(widget.city);
      if (cityInfo != null) {
        weatherData = await WeatherApiService.fetchWeatherData(
          cityInfo!['latitude'],
          cityInfo!['longitude'],
        );
        //weatherData frissítése
        setState(() {});
      } else {
        print('No city information found for ${widget.city}');
      }
    } catch (e) {
      print('Error retrieving city info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.isEmpty ? 'City' : widget.city),
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
              child: CustomCard(dateData: weatherData?.current),
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
