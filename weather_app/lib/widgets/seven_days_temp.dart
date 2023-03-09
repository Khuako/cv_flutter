import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../model/weather_forecast_daily.dart';
import 'forecastCard.dart';

class SevenDaysTemp extends StatefulWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const SevenDaysTemp(this.snapshot);

  @override
  State<SevenDaysTemp> createState() => _SevenDaysTempState();
}

class _SevenDaysTempState extends State<SevenDaysTemp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '7-Day Weather Forecast'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 240,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                    width: MediaQuery.of(context).size.width / 2.7,
                    height: 200,
                    color: Colors.black87,
                    child: forecastCard(widget.snapshot, index),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
              itemCount: widget.snapshot.data!.list!.length),
        ),
      ],
    );
  }
}
