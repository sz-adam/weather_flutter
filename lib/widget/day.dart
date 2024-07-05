import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';

class Day extends StatelessWidget {
  const Day({Key? key, this.dailyData}) : super(key: key);
  final DailyData? dailyData;


  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        const Text(
          'Daily',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: dailyData!.time.map((time) {
                DateTime date = DateTime.parse(
                    time); // String dátum DateTime objektummá alakítása
                int idx = dailyData!.time.indexOf(time);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).colorScheme.primaryFixedDim),
                  child: Column(
                    children: [
                      Text(
                        '${date.day}.',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Icon(
                        Icons.sunny,
                        color: Colors.yellow,
                        size: 30,
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            'Min: ${dailyData!.temperature2mMin[idx]}°C',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Max:  ${dailyData!.temperature2mMax[idx]}°C',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                           
                          Row(
                            children: [
                              const Icon(
                                Icons.water,
                                color: Colors.blue,
                              ),
                              Text(
                                '  ${dailyData!.rainSum[idx]}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.air,
                                color: Colors.blue,
                              ),
                              Text(
                                '  ${dailyData!.windSpeed10mMax[idx]} km/h',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
