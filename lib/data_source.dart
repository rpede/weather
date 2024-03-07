import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather/models.dart';

class FakeDataSource {
  Future<WeeklyForecastDto> getWeeklyForecast() async {
    final json = await rootBundle.loadString("assets/weekly_forecast.json");
    return WeeklyForecastDto.fromJson(jsonDecode(json));
  }
}
