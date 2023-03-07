import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/model/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const TempView(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var icon = forecastList![0].getIconUrl();
    var temp = forecastList[0].temp.day.toStringAsFixed(0);
    var description = forecastList[0].weather[0].description.toUpperCase();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            icon,
            scale: 0.7,
            color: Colors.black87,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                '$temp °C',
                style: const TextStyle(fontSize: 54, color: Colors.black87),
              ),
              Text(
                '$description',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )
            ],
          ),
        ],
      ),
    );
  }
}
