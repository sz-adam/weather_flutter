import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';
import 'package:intl/intl.dart';

class HourlyDay extends StatelessWidget {
  const HourlyDay({Key? key, this.hourlyData}) : super(key: key);

  final HourlyData? hourlyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Hourly',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: hourlyData!.time.map((time) {
              int idx = hourlyData!.time.indexOf(time);
              DateTime date = DateTime.parse(time);
              // Formázott dátum
              String formattedDate = DateFormat('MM-dd').format(date);
              // Formázott idő
              String formattedTime = DateFormat('HH:mm').format(date);
              return Container(
               width: MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Theme.of(context).colorScheme.primaryFixedDim),
                child: Column(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.wb_sunny,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Min: ${hourlyData!.temperature2m[idx]}°C',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Max: ${hourlyData!.temperature2m[idx]}°C',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.water,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${hourlyData!.rain[idx]} mm',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.air,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${hourlyData!.windSpeed10m[idx]} km/h',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
