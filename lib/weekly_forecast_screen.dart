import 'package:flutter/material.dart';
import 'package:weather/data_source.dart';
import 'package:weather/models.dart';
import 'package:weather/weekly_Forecast_list.dart';

import 'weather_sliver_app_bar.dart';

class WeeklyForecastScreen extends StatelessWidget {
  const WeeklyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FakeDataSource().getWeeklyForecast(),
        builder: (context, snapshot) => CustomScrollView(
          slivers: <Widget>[
            WeatherSliverAppBar(),
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

  SliverFillRemaining _buildSpinner() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  SliverToBoxAdapter _buildError(
      AsyncSnapshot<WeeklyForecastDto> snapshot, BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          snapshot.error.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
