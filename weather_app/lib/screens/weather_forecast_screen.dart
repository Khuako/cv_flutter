import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/detail_view.dart';
import '../model/weather_forecast_daily.dart';
import '../widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  Future<WeatherForecast>? forecastObject;
  String _cityName = 'London';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forecastObject = WeatherApi().fetchWeatherForecastWithCity(_cityName);
    // forecastObject!.then((weather) {
    //   print(weather.list![0].weather[0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Weather Forecast'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_city),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CityView(snapshot),
                      const SizedBox(
                        height: 50,
                      ),
                      TempView(snapshot),
                      const SizedBox(
                        height: 50,
                      ),
                      DetailView(snapshot),
                    ],
                  );
                } else {
                  return const Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.black87,
                      size: 100,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
