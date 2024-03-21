typedef JsonObject = Map<String, dynamic>;

/// Holds the same data as as response from Open-Meteo, but in a form that makes
/// it simpler to use in charts.
class WeatherChartData {
  /// Hourly Weather Variables
  final List<TimeSeriesVariable>? hourly;

  /// Daily Weather Variables
  final List<TimeSeriesVariable>? daily;

  WeatherChartData({this.hourly, this.daily});

  static WeatherChartData fromJson(Map<String, dynamic> json) =>
      WeatherDataConverter.convert(json);
}

/// A measure that changes over time
class TimeSeriesVariable {
  final String name;
  final String? unit;
  final List<TimeSeriesDatum> values;

  TimeSeriesVariable({required this.name, this.unit, required this.values});

  List<TimeSeriesDatum> fromNow() {
    final now = DateTime.now();
    return values.skipWhile((value) => value.domain.isBefore(now)).toList();
  }
}

/// A single point
class TimeSeriesDatum {
  final DateTime domain;
  final num measure;

  TimeSeriesDatum({required this.domain, required this.measure});
}

const _kTime = 'time';
const _kHourly = 'hourly';
const _kDaily = 'daily';
const _kUnits = 'units';

class WeatherDataConverter {
  static WeatherChartData convert(Map<String, dynamic> json) {
    return WeatherChartData(
      daily: convertGroup(json, group: _kDaily),
      hourly: convertGroup(json, group: _kHourly),
    );
  }

  static List<TimeSeriesVariable>? convertGroup(Map<String, dynamic> json,
      {required String group}) {
    if (!json.containsKey(group)) return null;

    // Find out what variables exist the group.
    final variables =
        (json[group] as JsonObject).keys.where((key) => key != _kTime);

    return variables
        .map((variable) =>
            convertVariable(json, group: group, variable: variable)!)
        .toList();
  }

  static TimeSeriesVariable? convertVariable(Map<String, dynamic> json,
      {required String group, required String variable}) {
    if (!json.containsKey(group)) return null;

    // Find unit for variable
    final unit = json['${group}_$_kUnits']?[variable];

    // A data point is the value of variable at a specific point in time
    final values = List.generate(
      (json[group][_kTime] as List).length,
      (index) => TimeSeriesDatum(
        domain: DateTime.parse(json[group][_kTime][index]),
        measure: json[group][variable][index],
      ),
    );

    return TimeSeriesVariable(name: variable, unit: unit, values: values);
  }
}
