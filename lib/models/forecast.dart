
class HistoricWeatherDto {
    double? latitude;
    double? longitude;
    double? generationtimeMs;
    int? utcOffsetSeconds;
    String? timezone;
    String? timezoneAbbreviation;
    int? elevation;
    HistoricDailyUnits? dailyUnits;
    HistoricDaily? daily;

    HistoricWeatherDto({this.latitude, this.longitude, this.generationtimeMs, this.utcOffsetSeconds, this.timezone, this.timezoneAbbreviation, this.elevation, this.dailyUnits, this.daily});

    HistoricWeatherDto.fromJson(Map<String, dynamic> json) {
        latitude = (json["latitude"] as num).toDouble();
        longitude = (json["longitude"] as num).toDouble();
        generationtimeMs = (json["generationtime_ms"] as num).toDouble();
        utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
        timezone = json["timezone"];
        timezoneAbbreviation = json["timezone_abbreviation"];
        elevation = (json["elevation"] as num).toInt();
        dailyUnits = json["daily_units"] == null ? null : HistoricDailyUnits.fromJson(json["daily_units"]);
        daily = json["daily"] == null ? null : HistoricDaily.fromJson(json["daily"]);
    }

    static List<HistoricWeatherDto> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => HistoricWeatherDto.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["latitude"] = latitude;
        data["longitude"] = longitude;
        data["generationtime_ms"] = generationtimeMs;
        data["utc_offset_seconds"] = utcOffsetSeconds;
        data["timezone"] = timezone;
        data["timezone_abbreviation"] = timezoneAbbreviation;
        data["elevation"] = elevation;
        if(dailyUnits != null) {
            data["daily_units"] = dailyUnits?.toJson();
        }
        if(daily != null) {
            data["daily"] = daily?.toJson();
        }
        return data;
    }
}

class HistoricDaily {
    List<String>? time;
    List<double>? temperature2MMean;

    HistoricDaily({this.time, this.temperature2MMean});

    HistoricDaily.fromJson(Map<String, dynamic> json) {
        time = json["time"] == null ? null : List<String>.from(json["time"]);
        temperature2MMean = json["temperature_2m_mean"] == null ? null : List<double>.from(json["temperature_2m_mean"]);
    }

    static List<HistoricDaily> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => HistoricDaily.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(time != null) {
            data["time"] = time;
        }
        if(temperature2MMean != null) {
            data["temperature_2m_mean"] = temperature2MMean;
        }
        return data;
    }
}

class HistoricDailyUnits {
    String? time;
    String? temperature2MMean;

    HistoricDailyUnits({this.time, this.temperature2MMean});

    HistoricDailyUnits.fromJson(Map<String, dynamic> json) {
        time = json["time"];
        temperature2MMean = json["temperature_2m_mean"];
    }

    static List<HistoricDailyUnits> fromList(List<Map<String, dynamic>> list) {
        return list.map((map) => HistoricDailyUnits.fromJson(map)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["time"] = time;
        data["temperature_2m_mean"] = temperature2MMean;
        return data;
    }
}

class WeeklyForecastDto {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  int? elevation;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeeklyForecastDto(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.dailyUnits,
      this.daily});

  WeeklyForecastDto.fromJson(Map<String, dynamic> json) {
    latitude = (json["latitude"] as num).toDouble();
    longitude = (json["longitude"] as num).toDouble();
    generationtimeMs = (json["generationtime_ms"] as num).toDouble();
    utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = (json["elevation"] as num).toInt();
    dailyUnits = json["daily_units"] == null
        ? null
        : DailyUnits.fromJson(json["daily_units"]);
    daily = json["daily"] == null ? null : Daily.fromJson(json["daily"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["generationtime_ms"] = generationtimeMs;
    data["utc_offset_seconds"] = utcOffsetSeconds;
    data["timezone"] = timezone;
    data["timezone_abbreviation"] = timezoneAbbreviation;
    data["elevation"] = elevation;
    if (dailyUnits != null) {
      data["daily_units"] = dailyUnits?.toJson();
    }
    if (daily != null) {
      data["daily"] = daily?.toJson();
    }
    return data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weatherCode;
  List<double>? temperature2MMax;
  List<double>? temperature2MMin;

  Daily(
      {this.time,
      this.weatherCode,
      this.temperature2MMax,
      this.temperature2MMin});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    weatherCode = json["weather_code"] == null
        ? null
        : List<int>.from(json["weather_code"]);
    temperature2MMax = json["temperature_2m_max"] == null
        ? null
        : List<double>.from(json["temperature_2m_max"]);
    temperature2MMin = json["temperature_2m_min"] == null
        ? null
        : List<double>.from(json["temperature_2m_min"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (time != null) {
      data["time"] = time;
    }
    if (weatherCode != null) {
      data["weather_code"] = weatherCode;
    }
    if (temperature2MMax != null) {
      data["temperature_2m_max"] = temperature2MMax;
    }
    if (temperature2MMin != null) {
      data["temperature_2m_min"] = temperature2MMin;
    }
    return data;
  }
}

class DailyUnits {
  String? time;
  String? weatherCode;
  String? temperature2MMax;
  String? temperature2MMin;

  DailyUnits(
      {this.time,
      this.weatherCode,
      this.temperature2MMax,
      this.temperature2MMin});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    weatherCode = json["weather_code"];
    temperature2MMax = json["temperature_2m_max"];
    temperature2MMin = json["temperature_2m_min"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["time"] = time;
    data["weather_code"] = weatherCode;
    data["temperature_2m_max"] = temperature2MMax;
    data["temperature_2m_min"] = temperature2MMin;
    return data;
  }
}

// 0 	Clear sky
// 1, 2, 3 	Mainly clear, partly cloudy, and overcast
// 45, 48 	Fog and depositing rime fog
// 51, 53, 55 	Drizzle: Light, moderate, and dense intensity
// 56, 57 	Freezing Drizzle: Light and dense intensity
// 61, 63, 65 	Rain: Slight, moderate and heavy intensity
// 66, 67 	Freezing Rain: Light and heavy intensity
// 71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
// 77 	Snow grains
// 80, 81, 82 	Rain showers: Slight, moderate, and violent
// 85, 86 	Snow showers slight and heavy
// 95 * 	Thunderstorm: Slight or moderate
// 96, 99 * 	Thunderstorm with slight and heavy hail
enum WeatherCode {
  clearSky(0, 'Clear sky', "wi-day-sunny"),

  mainlyClear(1, 'Mainly clear', 'wi-day-sunny-overcast'),
  partlyCloudy(2, 'Partly cloudy', 'wi-day-sunny-overcast'),
  overcast(3, 'Overcast', 'wi-day-cloudy'),

  fog(45, 'Fog', 'wi-day-fog'),
  depositingRimeFog(48, 'Depositing rime fog', 'wi-day-fog'),

  drizzleLight(51, 'Drizzle: Light intensity', 'wi-day-sprinkle'),
  drizzleModerate(53, 'Drizzle: Moderate intensity', 'wi-day-sprinkle'),
  drizzleDense(55, 'Drizzle: Dense intensity', 'wi-day-rain-mix'),

  freezingDrizzleLight(
      56, 'Freezing Drizzle: Light intensity', 'wi-day-sprinkle'),
  freezingDrizzleDense(
      57, 'Freezing Drizzle: dense intensity', 'wi-day-rain-mix'),

  rainSlight(61, 'Rain: Slight intensity', 'wi-day-rain-mix'),
  rainModerate(63, 'Rain: Moderate intensity', 'wi-day-rain'),
  rainHeavy(65, 'Rain: Heavy intensity', 'wi-day-showers'),

  freezingRainLight(66, 'Freezing Rain: Light intensity', 'wi-sleet'),
  freezingRainHeavy(67, 'Freezing Rain: Heavy intensity', 'wi-sleet'),

  snowFallSlight(71, 'Snow fall: Slight intensity', 'wi-day-snow'),
  snowFallModerate(73, 'Snow fall: Moderate intensity', 'wi-day-snow'),
  snowFallHeavy(75, 'Snow fall: Heavy intensity', 'wi-day-snow'),

  snowGrains(77, 'Snow grains', 'wi-day-hail'),

  rainShowersSlight(80, 'Rain showers: Slight', 'wi-day-showers'),
  rainShowersModerate(81, 'Rain showers: Moderate', 'wi-day-showers'),
  rainShowersVoilent(82, 'Rain showers: Violent', 'wi-day-showers'),

  snowShowersSlight(85, 'Snow showers: Slight', 'wi-day-snow'),
  snowShowersHeavy(86, 'Snow showers: Heavy', 'wi-day-snow'),

  thunerstorm(95, 'Thunderstorm: Slight or moderate', 'wi-day-thunderstorm'),
  thunderstormSlightHail(
      96, 'Thunderstorm with slight hail', 'wi-day-thunderstorm'),
  thunderstormHeavyHail(
      99, 'Thunderstorm with heavy hail', 'wi-day-thunderstorm'),
  ;

  final int value;
  final String description;
  final String icon;
  const WeatherCode(this.value, this.description, this.icon);

  factory WeatherCode.fromInt(int value) {
    return WeatherCode.values.singleWhere((code) => code.value == value);
  }
}