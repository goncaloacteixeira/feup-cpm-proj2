import 'package:flutter/material.dart';
import 'package:w4cast/models/city.dart';

import '../utils.dart';

class CityDayWeatherItem extends StatelessWidget {
  final DayWeather day;

  const CityDayWeatherItem({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  return snapshot.hasData
                      ? Text(
                          snapshot.data!,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      : const Text('loading');
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
    );
  }
}
