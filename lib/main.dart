// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cv_flutter/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCVScreen(),
    );
  }
}

class MyCVScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 90,
                foregroundImage: AssetImage("assets/maxresdefault.jpg"),
              ),
              Text(
                "Roman K",
                style: nameTextStyle,
              ),
              Text("Flutter Developer"),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.call),
                    title: Text(
                      "+79537777777",
                      style: numTextStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      "pilipop1111@gmail.com",
                      style: numTextStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        children: [
                          Text("Education"),
                          Text("KubSU, Krasnodar"),
                          Text("Liceum 90, Krasnodar"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Column(
                        children: [
                          Text("Work Expirience"),
                          Text("Flutter Developer"),
                          Text("Anime Watcher")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
