import 'package:flutter/material.dart';
import 'package:flutter_weather/model/weather_data.dart';
import 'package:intl/intl.dart';

class HourlyDay extends StatelessWidget {
  const HourlyDay({Key? key, this.hourlyData, this.dailyData})
      : super(key: key);

  final DailyData? dailyData;
  final HourlyData? hourlyData;

  @override
  Widget build(BuildContext context) {
    // Aktuális idő
    DateTime now = DateTime.now();

    //Az időzóna eltolása, ami a helyi idő és az UTC közötti különbség.
    Duration timeZoneOffset = now.timeZoneOffset;

    // Szűrjük az óránkénti adatokat az aktuális időtől kezdve
    List<String> filteredTimes = hourlyData!.time.where((time) {
      DateTime date = DateTime.parse(time);
      return date.isAfter(now);
    }).toList();

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
            children: filteredTimes.map((time) {
              int idx = hourlyData!.time.indexOf(time);
              DateTime date = DateTime.parse(time);

              // napi indexet
              int dayIndex = date
                  .difference(DateTime.parse(hourlyData!.time.first))
                  .inDays;

              String formattedDate = DateFormat('MM.dd').format(date);
              String formattedTime = DateFormat('HH:mm').format(date);

              // napfelkelte és naplemente időpontok
              DateTime sunrise = DateTime.parse(dailyData!.sunrise[dayIndex])
                  .add(timeZoneOffset);
              DateTime sunset = DateTime.parse(dailyData!.sunset[dayIndex])
                  .add(timeZoneOffset);

              IconData icon = (date.isAfter(sunrise) && date.isBefore(sunset))
                  ? Icons.wb_sunny
                  : Icons.nights_stay;

              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
                child: Column(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Icon(
                      icon,
                      color: (icon == Icons.wb_sunny)
                          ? Colors.yellow
                          : Colors.blue,
                      size: 30,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${hourlyData!.temperature2m[idx]}°C',
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
                            const SizedBox(width: 4),
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
                            const SizedBox(width: 4),
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
