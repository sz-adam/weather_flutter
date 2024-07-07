import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';

class SunMoon extends StatelessWidget {
  const SunMoon({
    Key? key,
    this.dailyData,
    required this.dateData,
    required this.size,
  }) : super(key: key);

  final DailyData? dailyData;
  final CurrentData? dateData;
  final double size;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (dateData!.rain > 0) {
      icon = Icons.cloudy_snowing;
      color = Colors.blue;
    } else {
      icon = dateData!.isDay == 1 ? Icons.wb_sunny : Icons.nights_stay;
      color = dateData!.isDay == 1 ? Colors.yellow : Colors.blue;
    }

    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
