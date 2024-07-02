class WeatherData {
  final Map<String, String> hourlyUnits;
  final HourlyData hourly;
  final Map<String, String> dailyUnits;
  final DailyData daily;

  WeatherData({
    required this.hourlyUnits,
    required this.hourly,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      hourlyUnits: Map<String, String>.from(json['hourly_units']),
      hourly: HourlyData.fromJson(json['hourly']),
      dailyUnits: Map<String, String>.from(json['daily_units']),
      daily: DailyData.fromJson(json['daily']),
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

  DailyData({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.windSpeed10mMax,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) {
    return DailyData(
      time: List<String>.from(json['time']),
      temperature2mMax: List<double>.from(json['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['temperature_2m_min']),
      windSpeed10mMax: List<double>.from(json['wind_speed_10m_max']),
    );
  }
}
