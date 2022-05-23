import 'package:flutter/material.dart';
import 'package:w4cast/models/city.dart';

class CityPage extends StatelessWidget {
  final City city;

const CityPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(city.city),
          ),
          body: Text(city.toString())
      );
  }
}