import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/weather_forecast_daily.dart';
import '../utiliies/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView(this.snapshot);
  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var pressure = forecastList![0].pressure * 0.750062;
    var humidity = forecastList[0].humidity;
    var wind = forecastList[0].speed * 3.6;
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Util.getItem(FontAwesomeIcons.thermometerThreeQuarters,
              pressure.round(), 'mm Hg'),
          Util.getItem(Icons.water_drop, humidity, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind.round(), 'km/h')
        ],
      ),
    );
  }
}
