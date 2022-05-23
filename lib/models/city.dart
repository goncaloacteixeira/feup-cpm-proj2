class Weather {
  final num temperature;
  final String icon;
  final DateTime dateTime;

  Weather(this.temperature, this.icon, this.dateTime);

  @override
  String toString() {
    return 'Weather{temperature: $temperature, icon: $icon, dateTime: $dateTime}';
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
            (weather["current"]["dt"] as int) * 1000));

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
      hourlyWeather.add(Weather(hour["temp"] as num, hour["weather"][0]["icon"],
          DateTime.fromMillisecondsSinceEpoch((hour["dt"] as int) * 1000)));
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
