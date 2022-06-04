import 'package:flutter/material.dart';
import 'package:w4cast/components/city_day_weather_item.dart';
import 'package:w4cast/components/city_hour_weather_item.dart';
import 'package:w4cast/components/city_weather_details_item.dart';
import 'package:w4cast/models/city.dart';
import 'package:w4cast/utils.dart';

class CityPage extends StatelessWidget {
  final City city;

  const CityPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(city.city),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(
                          "http://openweathermap.org/img/wn/${city.currentWeather.icon}@4x.png"),
                    ),
                    Text(
                      "${city.currentWeather.temperature.toStringAsFixed(0)}\u00B0",
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(color: Colors.black),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${city.todayWeather.max.toStringAsFixed(0)}\u00B0",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.color),
                        ),
                        Text(
                          "/",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.color),
                        ),
                        Text(
                          "${city.todayWeather.min.toStringAsFixed(0)}\u00B0",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      ?.color),
                        ),
                      ],
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (Weather hour in city.hourlyWeather.sublist(0, 5))
                      CityHourWeatherItem(hour: hour)
                  ],
                )),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CityWeatherDetailsItem(
                      property: "Humidade",
                      icon: Icons.water_drop,
                      value: Utils.toPercentage(city.currentWeather.humidity)),
                  const SizedBox(
                    height: 30,
                  ),
                  CityWeatherDetailsItem(
                      property: "Nuvens",
                      icon: Icons.cloud,
                      value: Utils.toPercentage(city.currentWeather.clouds)),
                  const SizedBox(
                    height: 30,
                  ),
                  CityWeatherDetailsItem(
                      property: "Visibilidade",
                      icon: Icons.visibility,
                      value: Utils.classifyVisibility(
                          city.currentWeather.visibility)),
                  const SizedBox(
                    height: 30,
                  ),
                  CityWeatherDetailsItem(
                      property: "Vento",
                      icon: Icons.air,
                      value: Utils.windSpeed(city.currentWeather.windSpeed))
                ],
              ),
            ),
            const Divider(),
            Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (DayWeather day in city.dailyWeather)
                      CityDayWeatherItem(day: day)
                  ],
                ))
          ],
        ));
  }
}
