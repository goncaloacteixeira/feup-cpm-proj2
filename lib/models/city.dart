class Weather {
  final num temperature;
  final String icon;
  final DateTime dateTime;
  final num humidity;
  final num clouds;
  final num uvi;
  final num visibility;
  final num windSpeed;

  Weather(this.temperature, this.icon, this.dateTime, this.humidity,
      this.clouds, this.uvi, this.visibility, this.windSpeed);

  @override
  String toString() {
    return 'Weather{temperature: $temperature, icon: $icon, dateTime: $dateTime, humidity: $humidity, clouds: $clouds, uvi: $uvi, visibility: $visibility, windSpeed: $windSpeed}';
  }
}

class DayWeather {
  final num min;
  final num max;
  final DateTime day;
  final String icon;

  DayWeather(this.min, this.max, this.day, this.icon);

  @override
  String toString() {
    return 'DayWeather{min: $min, max: $max, day: $day, icon: $icon}';
  }
}

class City {
  final String city;
  final String country;
  double lat;
  double lon;
  late DayWeather todayWeather;
  late Weather currentWeather;
  late List<DayWeather> dailyWeather;
  late List<Weather> hourlyWeather;

  late Map<String, dynamic> _weather;

  Map<String, dynamic> get weather => _weather;

  set weather(Map<String, dynamic> weather) {
    _weather = weather;

    todayWeather = DayWeather(
        weather["daily"][0]["temp"]["min"] as num,
        weather["daily"][0]["temp"]["max"] as num,
        DateTime.fromMillisecondsSinceEpoch(
            (weather["daily"][0]["dt"] as int) * 1000),
        weather["daily"][0]["weather"][0]["icon"]);

    currentWeather = Weather(
      weather["current"]["temp"] as num,
      weather["current"]["weather"][0]["icon"],
      DateTime.fromMillisecondsSinceEpoch(
          (weather["current"]["dt"] as int) * 1000),
      weather["current"]["humidity"] as num,
      weather["current"]["clouds"] as num,
      weather["current"]["uvi"] as num,
      weather["current"]["visibility"] as num,
      weather["current"]["wind_speed"] as num,
    );

    dailyWeather = [];
    for (var day in weather["daily"]) {
      dailyWeather.add(DayWeather(
          day["temp"]["min"] as num,
          day["temp"]["max"] as num,
          DateTime.fromMillisecondsSinceEpoch((day["dt"] as int) * 1000),
          day["weather"][0]["icon"]));
    }

    hourlyWeather = [];
    for (var hour in weather["hourly"]) {
      hourlyWeather.add(Weather(
        hour["temp"] as num,
        hour["weather"][0]["icon"],
        DateTime.fromMillisecondsSinceEpoch((hour["dt"] as int) * 1000),
        hour["humidity"] as num,
        hour["clouds"] as num,
        hour["uvi"] as num,
        hour["visibility"] as num,
        hour["wind_speed"] as num,
      ));
    }
  }

  City(
      {required this.city,
      required this.country,
      required this.lat,
      required this.lon});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          country == other.country;

  @override
  int get hashCode => city.hashCode ^ country.hashCode;

  factory City.fromJson(String name, Map<String, dynamic> json) {
    return City(
        city: name, country: "Portugal", lat: json["lat"], lon: json["lon"]);
  }

  @override
  String toString() {
    return 'City{city: $city, country: $country, lat: $lat, lon: $lon, todayWeather: $todayWeather, currentWeather: $currentWeather, dailyWeather: $dailyWeather, hourlyWeather: $hourlyWeather}';
  }
}
