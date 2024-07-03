import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.dateData}) : super(key: key);

  final CurrentData? dateData;

  @override
  Widget build(BuildContext context) {
    if (dateData == null) {
      return const Center(
        child: Text('No data available'),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
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
                  Icon(
                    dateData!.isDay == 1 ? Icons.wb_sunny : Icons.nights_stay,
                    size: 60,
                    color: dateData!.isDay == 1 ? Colors.yellow : Colors.blue,
                  ),
                  Text(
                    '${dateData!.temperature2m.toStringAsFixed(1)}°',
                    style: const TextStyle(fontSize: 50),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Precipitation: ${dateData!.precipitation.toStringAsFixed(1)} mm',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Wind Speed: ${dateData!.windSpeed10m.toStringAsFixed(1)} m/s',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
