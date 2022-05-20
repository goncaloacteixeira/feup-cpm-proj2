import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w4cast/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _cities = ["Porto", "Faro"];

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var citiesString = prefs.getString("cities");
      if (citiesString != null) {
        _cities = citiesString.split(";");
      }
    });
  }

  Widget _generateCityItem(String city) {
    return Text(
      city,
      style: Theme
          .of(context)
          .textTheme
          .headline4,
    );
  }

  Dialog _addCityDialog() {
    return Dialog(
      elevation: 16,
      child: ListView(
        shrinkWrap: true,
        children: [
          for (var city in allCities) _generateCityItem(city)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cities:',
            ),
            for (var city in _cities) _generateCityItem(city)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => _addCityDialog());
        },
        tooltip: 'Add City',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
