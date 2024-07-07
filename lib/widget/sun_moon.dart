import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';

class SunMoon extends StatelessWidget {
  const SunMoon(
      {Key? key, this.dailyData, required this.dateData, required this.size})
      : super(key: key);
  final DailyData? dailyData;
  final CurrentData? dateData;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Icon(
      dateData!.isDay == 1 ? Icons.wb_sunny : Icons.nights_stay,
      size: size,
      color: dateData!.isDay == 1 ? Colors.yellow : Colors.blue,
    );
  }
}
