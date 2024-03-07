import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_source.dart';
import 'models.dart';
import 'weekly_forecast_list.dart';
import 'weather_sliver_app_bar.dart';

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
    return Scaffold(
      body: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) => CustomScrollView(
          slivers: <Widget>[
            WeatherSliverAppBar(onRefresh: loadForecast),
            if (snapshot.hasData)
              WeeklyForecastList(weeklyForecast: snapshot.data!)
            else if (snapshot.hasError)
              _buildError(snapshot, context)
            else
              _buildSpinner()
          ],
        ),
      ),
    );
  }

  Widget _buildSpinner() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Widget _buildError(
      AsyncSnapshot<WeeklyForecastDto> snapshot, BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          snapshot.error.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
