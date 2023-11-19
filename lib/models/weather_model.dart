class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String windSpeed;
  final String precipitation;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.windSpeed,
    required this.precipitation,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      windSpeed: json['wind']['speed'].toString(),
      precipitation: json['rain'] != null
          ? json['rain']['1h'].toString()
          : json['snow'] != null
              ? json['snow']['1h'].toString()
              : '0',
    );
  }
}
