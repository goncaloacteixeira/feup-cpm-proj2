import 'package:flutter/material.dart';
import 'package:w4cast/components/edit_city_item.dart';
import 'package:w4cast/constants.dart';

class EditCitiesPage extends StatelessWidget {
  const EditCitiesPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 18.0),
            child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return EditCityItem(name: allCities[index % 18]);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 18),
          ),
        ));
  }
}
