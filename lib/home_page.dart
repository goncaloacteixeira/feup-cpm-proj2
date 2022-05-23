import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w4cast/city_page.dart';
import 'package:w4cast/components/city_main_item.dart';
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
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    setState(() {
      _loading = true;
    });

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
      _loading = false;
    });
  }

  Widget _buildPage(BuildContext context) {
    if (_loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    } else {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(bottom: 18.0),
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  CityPage(city: _cities.toList()[index])))
                      .then((value) => _loadCities());
                },
                child: CityMainItem(city: _cities.toList()[index]),
              );
            },
            itemCount: _cities.length,
          ),
        ),
      );
    }
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
                            CupertinoDialogRoute(
                                context: context,
                                builder: (context) =>
                                    const EditCitiesPage(title: "Cities")))
                        .then((value) => _loadCities());
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: _buildPage(context));
  }
}
