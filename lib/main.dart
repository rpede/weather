import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_source.dart';
import 'weather_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<DataSource>(create: (context) => FakeDataSource()),
    ],
    child: const WeatherApp(),
  ));
}
