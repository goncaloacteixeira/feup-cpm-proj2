import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w4cast/EditCitiesPage.dart';

import 'package:http/http.dart' as http;
import 'package:w4cast/constants.dart';
import 'package:w4cast/models/city.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<City> _cities = {};

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    var citiesString = prefs.getString("cities");
    Set<City> newValue = {};
    if (citiesString != null) {
      var citiesNames = citiesString.split(";");
      for (var city in citiesNames) {
        final response = await http.get(Uri.parse(
            'http://api.openweathermap.org/geo/1.0/direct?q=$city,PT&limit=5&appid=$API_KEY'));
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          newValue.add(City.fromJson(jsonDecode(response.body)[0]));
        }
      }
    }

    for (var city in newValue) {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/onecall?lat=${city.lat}&lon=${city.lon}&exclude=minutely&units=metric&appid=$API_KEY'));
      if (response.statusCode == 200) {
        city.weather = jsonDecode(response.body);
      }
    }

    setState(() {
      _cities = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  const EditCitiesPage(title: "Cities")))
                      .then((value) => _loadCities());
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cities:',
            ),
            for (var city in _cities) Text(city.city),
          ],
        ),
      ),
    );
  }
}
