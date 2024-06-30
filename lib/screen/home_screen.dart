import 'package:flutter/material.dart';
import 'package:flutter_weather/widget/weather_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = ''; // Változó  tárolására

  void _openCitySearch() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => WeatherTextField(
        onSubmitted: (value) {
          setState(() {
            city = value; // Frissítjük a város nevét
          });
          Navigator.of(context).pop(); // Bezárjuk a modal ablakot
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.isEmpty ? 'City' : city), // Dinamikus cím 
        actions: [
          IconButton(
            onPressed: _openCitySearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}


