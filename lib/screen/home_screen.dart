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
            widget.city = value;
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

  String _getBackgroundImage() {
    if (weatherData != null) {
      if (weatherData!.current.rain > 0) {
        return 'assets/images/rain.jpg';
      } else {
        return 'assets/images/sun.jpg';
      }
    }
    // Alapértelmezett kép, ha nincs adat
    return 'assets/images/home.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
        actions: [
          IconButton(
            onPressed: _openCitySearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_getBackgroundImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: weatherData != null
                  ? SingleChildScrollView(
                      child: CustomCard(dateData: weatherData!.current),
                    )
                  : _buildNoDataWidget(), // Ha nincs adat, megjelenítjük az üzenetet
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Day(dailyData: weatherData?.daily),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'You entered a city that does not exist !!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
