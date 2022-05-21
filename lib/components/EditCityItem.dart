import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCityItem extends StatefulWidget {
  EditCityItem({super.key, required this.name});

  String name;

  @override
  State createState() {
    return _EditCityItemState();
  }
}

class _EditCityItemState extends State<EditCityItem> {
  Set<String> _cities = {};
  bool _isActive = false;

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
        _cities = Set.of(citiesString.split(";"));
      }

      _isActive = _cities.contains(widget.name);
    });
  }

  Future<void> _handleChange(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var citiesString = prefs.getString("cities");
      if (citiesString != null) {
        _cities = Set.of(citiesString.split(";"));
      }

      if (value) {
        _cities.add(widget.name);
      } else {
        if (_cities.contains(widget.name)) {
          _cities.remove(widget.name);
        }
      }
      _isActive = value;

      prefs.setString("cities", _cities.join(";"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(widget.name, style: Theme.of(context).textTheme.bodyText2,)),
        Switch.adaptive(value: _isActive, onChanged: _handleChange)
      ],
    );
  }
}