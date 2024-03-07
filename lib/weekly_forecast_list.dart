import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

import 'models.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecast;

  const WeeklyForecastList({super.key, required this.weeklyForecast});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final daily = weeklyForecast.daily!;
          final date = DateTime.parse(daily.time![index]);
          final weatherCode = WeatherCode.fromInt(daily.weatherCode![index]);
          final tempMax = daily.temperature2MMax![index];
          final tempMin = daily.temperature2MMin![index];
          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.grey[800]!,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: BoxedIcon(
                          WeatherIcons.fromString(weatherCode.icon,
                              fallback: WeatherIcons.na),
                          size: 70,
                        ),
                        // child: Image.asset(
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      Center(
                        child: Text(
                          date.day.toString(),
                          style: textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          weekdayAsString(date),
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(weatherCode.description),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$tempMax | $tempMin C',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 7,
      ),
    );
  }

  String weekdayAsString(DateTime time) {
    return switch (time.weekday) {
      DateTime.monday => 'Monday',
      DateTime.tuesday => 'Tuesday',
      DateTime.wednesday => 'Wednesday',
      DateTime.thursday => 'Thursday',
      DateTime.friday => 'Friday',
      DateTime.saturday => 'Saturday',
      DateTime.sunday => 'Sunday',
      _ => ''
    };
  }
}
