import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w4cast/edit_cities_page.dart';
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
          newValue.add(City.fromJson(city, jsonDecode(response.body)[0]));
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

  Widget _createCityWidget(City city) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                "http://openweathermap.org/img/wn/${city.weather["current"]["weather"][0]["icon"]}@2x.png"),
          ),
          Expanded(
            child: Text(
              city.city,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${(city.weather["current"]["temp"] as num).toStringAsFixed(0)}\u00B0",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                children: [
                  Text(
                      "${(city.weather["daily"][0]["temp"]["max"] as num).toStringAsFixed(0)}\u00B0",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Text("/"),
                  Text(
                      "${(city.weather["daily"][0]["temp"]["min"] as num).toStringAsFixed(0)}\u00B0",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              )
            ],
          )

        ],
      ),
    );
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
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _createCityWidget(_cities.toList()[index]);
        },
        itemCount: _cities.length,
      ),
    );
  }
}
