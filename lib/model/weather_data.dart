class WeatherData {
  final Map<String, String> hourlyUnits;
  final HourlyData hourly;
  final Map<String, String> dailyUnits;
  final DailyData daily;
  final CurrentData current;

  WeatherData({
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
    required this.current,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      current: CurrentData.fromJson(json['current']),
      hourlyUnits: Map<String, String>.from(json['hourly_units']),
      hourly: HourlyData.fromJson(json['hourly']),
      dailyUnits: Map<String, String>.from(json['daily_units']),
      daily: DailyData.fromJson(json['daily']),
    );
  }
}

class CurrentData {
  final String time;
  final int interval;
  final double temperature2m;
  final int isDay;
  final double precipitation;
  final double rain;
  final double windSpeed10m;

  CurrentData({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.isDay,
    required this.precipitation,
    required this.rain,
    required this.windSpeed10m,
  });

  factory CurrentData.fromJson(Map<String, dynamic> json) {
    return CurrentData(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      isDay: json['is_day'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class HourlyData {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> precipitationProbability;
  final List<double> rain;
  final List<double> windSpeed10m;

  HourlyData({
    required this.time,
    required this.temperature2m,
    required this.precipitationProbability,
    required this.rain,
    required this.windSpeed10m,
  });

  factory HourlyData.fromJson(Map<String, dynamic> json) {
    return HourlyData(
      time: List<String>.from(json['time']),
      temperature2m: List<double>.from(json['temperature_2m']),
      precipitationProbability:
          List<int>.from(json['precipitation_probability']),
      rain: List<double>.from(json['rain']),
      windSpeed10m: List<double>.from(json['wind_speed_10m']),
    );
  }
}

class DailyData {
  final List<String> time;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<double> windSpeed10mMax;
  final List<double> rainSum;
  final List<String> sunrise;
  final List<String> sunset;

  DailyData({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.windSpeed10mMax,
    required this.rainSum,
    required this.sunrise,
    required this.sunset,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: List<String>.from(json['time']),
      temperature2mMax: List<double>.from(json['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['temperature_2m_min']),
      windSpeed10mMax: List<double>.from(json['wind_speed_10m_max']),
      rainSum: List<double>.from(json['rain_sum']),
      sunrise:List<String>.from(json['sunrise']),
      sunset:List<String>.from(json['sunset']),
    );
  }
}
