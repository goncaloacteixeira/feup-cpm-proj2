import 'package:flutter/material.dart';

class CityWeatherDetailsItem extends StatelessWidget {
  final String property;
  final IconData icon;
  final String value;

  const CityWeatherDetailsItem(
      {super.key,
      required this.property,
      required this.icon,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Expanded(
            child:
                Text(property, style: Theme.of(context).textTheme.titleMedium)),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
