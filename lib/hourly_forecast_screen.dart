import 'dart:async';

import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_source.dart';
import 'models/time_series.dart';
import 'weather_sliver_app_bar.dart';
import 'widgets.dart';

class HourlyForecastScreen extends StatefulWidget {
  const HourlyForecastScreen({super.key});

  @override
  State<HourlyForecastScreen> createState() => _HourlyForecastScreenState();
}

class _HourlyForecastScreenState extends State<HourlyForecastScreen> {
  final controller = StreamController<WeatherChartData>();

  @override
  void initState() {
    super.initState();
    loadForecast();
  }

  Future<void> loadForecast() async {
    final future = context.read<DataSource>().getChartData();
    controller.addStream(future.asStream());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadForecast,
      child: StreamBuilder<WeatherChartData>(
        stream: controller.stream,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              const WeatherSliverAppBar(),
              if (snapshot.hasData) ...[
                SliverToBoxAdapter(
                  child: Card(
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(8),
                      child: TemperatureChart(snapshot.data!),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    child: Container(
                      height: 300,
                      padding: const EdgeInsets.all(8),
                      child: PrecipitationChart(snapshot.data!),
                    ),
                  ),
                )
              ] else if (snapshot.hasError)
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

class TemperatureChart extends StatelessWidget {
  final WeatherChartData data;
  const TemperatureChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final axisColor = charts.MaterialPalette.gray.shadeDefault;
    final actual = data.hourly!.singleWhere((e) => e.name == 'temperature_2m');
    final apparent =
        data.hourly!.singleWhere((e) => e.name == 'apparent_temperature');
    final unit = actual.unit;
    return charts.TimeSeriesChart(
      [
        charts.Series<TimeSeriesDatum, DateTime>(
          id: 'Actual',
          domainFn: (datum, _) => datum.domain,
          measureFn: (datum, _) => datum.measure,
          data: actual.fromNow(),
        ),
        charts.Series<TimeSeriesDatum, DateTime>(
          id: 'Feels-like',
          domainFn: (datum, _) => datum.domain,
          measureFn: (datum, _) => datum.measure,
          data: apparent.fromNow(),
        ),
      ],
      animate: false,
      behaviors: [
        charts.ChartTitle("Temperature $unit",
            titleStyleSpec: charts.TextStyleSpec(color: axisColor)),
        charts.SeriesLegend(),
      ],

      /// Assign a custom style for the domain axis.
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: charts.TextStyleSpec(color: axisColor),
          // Change the line colors to match text color.
          lineStyle: charts.LineStyleSpec(color: axisColor),
        ),
      ),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: charts.TextStyleSpec(color: axisColor),
          // Change the line colors to match text color.
          lineStyle: charts.LineStyleSpec(color: axisColor),
        ),
      ),
    );
  }
}

class PrecipitationChart extends StatelessWidget {
  final WeatherChartData data;
  const PrecipitationChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final axisColor = charts.MaterialPalette.gray.shadeDefault;
    final precipitation =
        data.hourly!.singleWhere((e) => e.name == 'precipitation');
    final probability = data.hourly!
        .singleWhere((e) => e.name == 'precipitation_probability')
        .fromNow();
    final unit = precipitation.unit;
    return charts.TimeSeriesChart(
      [
        charts.Series<TimeSeriesDatum, DateTime>(
          id: 'Precipitation',
          domainFn: (datum, _) => datum.domain,
          measureFn: (datum, _) => datum.measure,
          colorFn: (datum, index) =>
              charts.ColorUtil.fromDartColor(Color.alphaBlend(
            Color.fromRGBO(255, 255, 255, probability[index!].measure / 100),
            Colors.blueGrey,
          )),
          data: precipitation.fromNow(),
        ),
      ],
      animate: false,
      defaultRenderer: charts.BarRendererConfig<DateTime>(),
      behaviors: [
        charts.ChartTitle("Precipitation $unit",
            titleStyleSpec: charts.TextStyleSpec(color: axisColor)),
      ],

      /// Assign a custom style for the domain axis.
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          // Tick and Label styling here.
          labelStyle: charts.TextStyleSpec(color: axisColor),
          // Change the line colors to match text color.
          lineStyle: charts.LineStyleSpec(color: axisColor),
        ),
      ),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          // Tick and Label styling here.
          labelStyle: charts.TextStyleSpec(color: axisColor),
          // Change the line colors to match text color.
          lineStyle: charts.LineStyleSpec(color: axisColor),
        ),
      ),
    );
  }
}
