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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["generationtime_ms"] = generationtimeMs;
    _data["utc_offset_seconds"] = utcOffsetSeconds;
    _data["timezone"] = timezone;
    _data["timezone_abbreviation"] = timezoneAbbreviation;
    _data["elevation"] = elevation;
    if (dailyUnits != null) {
      _data["daily_units"] = dailyUnits?.toJson();
    }
    if (daily != null) {
      _data["daily"] = daily?.toJson();
    }
    return _data;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if (temperature2MMax != null) {
      _data["temperature_2m_max"] = temperature2MMax;
    }
    if (temperature2MMin != null) {
      _data["temperature_2m_min"] = temperature2MMin;
    }
    return _data;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["weather_code"] = weatherCode;
    _data["temperature_2m_max"] = temperature2MMax;
    _data["temperature_2m_min"] = temperature2MMin;
    return _data;
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
  clearSky(0, 'Clear sky', 'skc'),

  mainlyClear(1, 'Mainly clear', 'few'),
  partlyCloudy(2, 'Partly cloudy', 'sct'),
  overcast(3, 'Overcast', 'ovc'),

  fog(45, 'Fog', 'fg'),
  depositingRimeFog(48, 'Depositing rime fog', 'fg'),

  drizzleLight(51, 'Drizzle: Light intensity', 'minus_ra'),
  drizzleModerate(53, 'Drizzle: Moderate intensity', 'minus_ra'),
  drizzleDense(55, 'Drizzle: Dense intensity', 'minus_ra'),

  freezingDrizzleLight(56, 'Freezing Drizzle: Light intensity', 'fzra'),
  freezingDrizzleDense(57, 'Freezing Drizzle: dense intensity', 'fzra'),

  rainSlight(61, 'Rain: Slight intensity', 'minus_ra'),
  rainModerate(63, 'Rain: Moderate intensity', 'ra'),
  rainHeavy(65, 'Rain: Heavy intensity', 'ra'),

  freezingRainLight(66, 'Freezing Rain: Light intensity', 'ra_fzra'),
  freezingRainHeavy(66, 'Freezing Rain: Heavy intensity', 'ra_fzra'),

  snowFallSlight(71, 'Snow fall: Slight intensity', 'sn'),
  snowFallModerate(73, 'Snow fall: Moderate intensity', 'sn'),
  snowFallHeavy(75, 'Snow fall: Heavy intensity', 'blizzard'),

  snowGrains(77, 'Snow grains', 'snip'),

  rainShowersSlight(80, 'Rain showers: Slight', 'shra'),
  rainShowersModerate(81, 'Rain showers: Moderate', 'shra'),
  rainShowersVoilent(82, 'Rain showers: Violent', 'shra'),

  snowShowersSlight(85, 'Snow showers: Slight', 'ip'),
  snowShowersHeavy(86, 'Snow showers: Heavy', 'raip'),

  thunerstorm(95, 'Thunderstorm: Slight or moderate', 'scttsra'),
  thunderstormSlightHail(96, 'Thunderstorm with slight hail', 'tsra'),
  thunderstormHeavyHail(99, 'Thunderstorm with heavy hail', 'tsra'),
  ;

  final int value;
  final String description;
  final String icon;
  const WeatherCode(this.value, this.description, this.icon);

  get imageAsset {
    return 'assets/$icon.png';
  }

  factory WeatherCode.fromInt(int value) {
    return WeatherCode.values.singleWhere((code) => code.value == value);
  }
}
