import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utiliies/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data!.list;
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  var dayOfWeek = '';
  var tempDay = forecastList[index].temp.day.toStringAsFixed(0);
  dayOfWeek = fullDate.split(',')[0];
  var icon = forecastList[index].getIconUrl();
  var iconNight = (index == 6
      ? forecastList[index].getIconUrl()
      : forecastList[index + 1].getIconUrl());
  var tempNight = forecastList[index].temp.night.toStringAsFixed(0);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            dayOfWeek,
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Day',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '$tempDay °C',
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Image.network(
                icon,
                color: Colors.white,
                scale: 1.2,
              ),
            ],
          ),
          const Text(
            'Night',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  '$tempNight °C',
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Image.network(
                icon,
                color: Colors.white,
                scale: 1.2,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
