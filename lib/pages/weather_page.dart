import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/models/weather_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: "920508b07345e265b07aca4fb82b4092");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'smoke':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thundersorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (_weather == null) {
      return const Scaffold(
        body: Center(
          child: SpinKitChasingDots(
            color: Colors.blue,
            size: 100,
          ),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.black54,
                  size: 26,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  _weather?.cityName ?? "",
                  style:
                      const TextStyle(fontFamily: 'PoppinsBold', fontSize: 30),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 60)),
              ],
            ),
            Lottie.asset(
              getWeatherCondition(_weather?.mainCondition),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.only(top: 150)),
            Text(
              '${_weather?.temperature.round() ?? ""}°C',
              style: const TextStyle(fontFamily: 'PoppinsBold', fontSize: 30),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(fontSize: 15),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/wind.json',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('${_weather?.windSpeed ?? ""} m/s')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/rain.json',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('${_weather?.precipitation ?? ""} mm')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
