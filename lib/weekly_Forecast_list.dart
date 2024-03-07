import 'package:flutter/material.dart';
import 'package:weather/main.dart';
import 'package:weather/models.dart';
import 'package:weather/server.dart';

class WeeklyForecastList extends StatelessWidget {
  final WeeklyForecastDto weeklyForecast;
  const WeeklyForecastList({super.key, required this.weeklyForecast});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final DailyForecast dailyForecast =
              Server.getDailyForecastByID(index);
          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  width: 200.0,
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
                        child: Image.network(
                          dailyForecast.imageId,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(
                          dailyForecast.getDate(currentDate.day).toString(),
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
                          dailyForecast.getWeekday(currentDate.weekday),
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(dailyForecast.description),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
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
}
