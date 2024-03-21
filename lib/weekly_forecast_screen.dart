import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_source.dart';
import 'models/forecast.dart';
import 'weather_sliver_app_bar.dart';
import 'weekly_forecast_list.dart';
import 'widgets.dart';

class WeeklyForecastScreen extends StatefulWidget {
  const WeeklyForecastScreen({super.key});

  @override
  State<WeeklyForecastScreen> createState() => _WeeklyForecastScreenState();
}

class _WeeklyForecastScreenState extends State<WeeklyForecastScreen> {
  final controller = StreamController<WeeklyForecastDto>();

  @override
  void initState() {
    super.initState();
    loadForecast();
  }

  Future<void> loadForecast() async {
    final future = context.read<DataSource>().getWeeklyForecast();
    controller.addStream(future.asStream());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadForecast,
      child: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              const WeatherSliverAppBar(),
              if (snapshot.hasData)
                WeeklyForecastList(weeklyForecast: snapshot.data!)
              else if (snapshot.hasError)
                SliverError(snapshot.error!)
              else
                const SliverProgressIndicator()
            ],
          );
        },
      ),
    );
  }
}
