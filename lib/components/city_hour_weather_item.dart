import 'package:flutter/material.dart';
import 'package:w4cast/models/city.dart';

import '../utils.dart';

class CityHourWeatherItem extends StatelessWidget {
  final Weather hour;

  const CityHourWeatherItem({super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Utils.toHourFormat(hour.dateTime),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).textTheme.headline1?.color)),
        Image(
          image:
              NetworkImage("http://openweathermap.org/img/wn/${hour.icon}.png"),
        ),
        Text(
          "${hour.temperature.toStringAsFixed(0)}\u00B0",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).textTheme.headline1?.color),
        ),
      ],
    );
  }
}
