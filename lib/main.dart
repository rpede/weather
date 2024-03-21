import 'package:flutter/material.dart';

import 'data_source.dart';

import 'package:provider/provider.dart';

import 'weather_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<DataSource>(create: (context) => RealDataSource()),
      ],
      child: const WeatherApp(),
    ),
  );
}
