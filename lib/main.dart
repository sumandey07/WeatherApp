import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/pages/weather_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WeatherPage(),
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
    );
  }
}
