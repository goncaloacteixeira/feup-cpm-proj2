import 'package:flutter/material.dart';
import 'package:w4cast/models/city.dart';

class CityMainItem extends StatelessWidget {
  final City city;

  const CityMainItem({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${city.weather["current"]["weather"][0]["icon"]}@2x.png"),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              city.city,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${(city.weather["current"]["temp"] as num).toStringAsFixed(0)}\u00B0",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${(city.weather["daily"][0]["temp"]["max"] as num).toStringAsFixed(0)}\u00B0",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.white),
                      ),
                      Text(
                          "/",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white)),
                      Text(
                        "${(city.weather["daily"][0]["temp"]["min"] as num).toStringAsFixed(0)}\u00B0",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
