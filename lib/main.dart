import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/data_source.dart';
import 'package:weather/weather_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<DataSource>(create: (context) => RealDataSource()),
    ],
    child: WeatherApp(),
  ));
}
