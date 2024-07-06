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
  bool isLoading = false;

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
          // Az új városnév beállítása
          widget.city = value;
          // Új keresés előtt a weatherData újból null
          weatherData = null;
          setState(() {
            isLoading = true; // Adatok lekérése előtt isLoading true
          });
          Navigator.of(ctx).pop();
          await _fetchWeatherData();
        },
      ),
    );
  }

  Future<void> _fetchWeatherData() async {
    try {
      setState(() {
        isLoading = true; // Adatok lekérése előtt isLoading true
      });

      cityInfo = await WeatherApiService.fetchCityInfo(widget.city);
      if (cityInfo != null) {
        weatherData = await WeatherApiService.fetchWeatherData(
          cityInfo!['latitude'],
          cityInfo!['longitude'],
        );
      } else {
        print('No city information found for ${widget.city}');
        // Ha nincs városinformáció, akkor weatherData null
        weatherData = null;
      }
    } catch (e) {
      print('Error retrieving city info: $e');
      weatherData = null;
    } finally {
      setState(() {
        isLoading = false; // Hiba esetén is isLoading false
      });
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
      //body magassága az appbar magasságát is magában foglalja
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.city),
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _openCitySearch,
            icon: const Icon(Icons.search,color: Colors.white,),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _getBackgroundImage(),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (weatherData == null
                    ? _buildNoDataWidget()
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: CustomCard(dateData: weatherData!.current),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Day(dailyData: weatherData?.daily),
                            ),
                          ),
                        ],
                      )),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'You entered a city that does not exist !!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
