import 'package:flutter/material.dart';
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
                      Column(
                        children: [
                          Text(Utils.toHourFormat(hour.dateTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.color)),
                          Image(
                            image: NetworkImage(
                                "http://openweathermap.org/img/wn/${hour.icon}.png"),
                          ),
                          Text(
                            "${hour.temperature.toStringAsFixed(0)}\u00B0",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.color),
                          ),
                        ],
                      )
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (DayWeather day in city.dailyWeather)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      "http://openweathermap.org/img/wn/${day.icon}.png"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder<String>(
                                  future: Utils.formatDate(day.day),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!);
                                    } else {
                                      return const Text("loading");
                                    }
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "${Utils.formatTemperature(day.max)}/${Utils.formatTemperature(day.min)}",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      )
                  ],
                ))
          ],
        ));
  }
}
