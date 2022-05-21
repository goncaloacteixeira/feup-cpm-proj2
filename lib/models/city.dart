class City {
  final String city;
  final String country;
  double lat;
  double lon;
  late Map<String, dynamic> weather;

  City({required this.city, required this.country, required this.lat, required this.lon});

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
        city: name,
        country: "Portugal",
        lat: json["lat"],
        lon: json["lon"]
    );
  }

  @override
  String toString() {
    return 'City{city: $city, country: $country, lat: $lat, lon: $lon, weather: $weather}';
  }
}