import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';
import 'package:flutter_weather/widget/sun_moon.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.dateData}) : super(key: key);

  final CurrentData? dateData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryFixedDim,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SunMoon(dateData: dateData, size: 60),
                  Text(
                    '${dateData!.temperature2m.toStringAsFixed(1)}°',
                    style: const TextStyle(fontSize: 50),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.water,
                    color: Colors.blue,
                  ),
                  Text(
                    '${dateData!.precipitation.toStringAsFixed(1)} mm',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.air,
                    color: Colors.blue,
                  ),
                  Text(
                    ' ${dateData!.windSpeed10m.toStringAsFixed(1)} m/s',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
