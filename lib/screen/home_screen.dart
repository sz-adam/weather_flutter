import 'package:flutter/material.dart';
import 'package:flutter_weather/services/city_name.dart';
import 'package:flutter_weather/widget/card.dart';
import 'package:flutter_weather/widget/day.dart';
import 'package:flutter_weather/widget/weather_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = '';  // Változó  tárolására
  double? latitude;
  double? longitude;

  void _openCitySearch() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WeatherTextField(
        onSubmitted: (value) async {
          setState(() {
            city = value;
          });
          Navigator.of(context).pop();
          try {
            var result = await WeatherApiService.fetchCityInfo(city);
            setState(() {
              latitude = result['latitude'];
              longitude = result['longitude'];
            });
            print(
                'Latitude: $latitude, Longitude: $longitude'); // Adatok megjelenítése a konzolon
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
                    Text('${longitude}'),
          Text('${latitude}'),
          Expanded(
            child: SingleChildScrollView(
              child: CustomCard(),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Day(),
            ),
          ),
        ],
      ),
    );
  }
}