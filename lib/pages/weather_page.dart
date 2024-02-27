import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/models/weather_model.dart';
import 'package:myapp/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("cca0039d2c19e2c37909c387f683a351");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/a.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/b.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/c.json';
      case 'thunderstorm':
        return 'assets/d.json';
      case 'clear':
        return 'assets/e.json';
      default:
        return 'assets/a.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[700],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_weather?.cityName ?? "Loading city..."),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text('${_weather?.temperature.round()} °C'),
              Text(_weather?.mainCondition ?? ""),
            ],
          ),
        ));
  }
}
