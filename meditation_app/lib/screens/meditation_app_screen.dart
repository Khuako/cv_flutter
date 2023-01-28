import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:meditation_app/models/item_model.dart';

class MeditationAppScreen extends StatefulWidget {
  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
      name: "Forest",
      audioPath: "meditation_audios/forest.mp3",
      ImagePath: "assets/forest.jpeg",
    ),
    Item(
      name: "Night",
      audioPath: "meditation_audios/night.mp3",
      ImagePath: "assets/night.jpeg",
    ),
    Item(
      name: "Ocean",
      audioPath: "meditation_audios/ocean.mp3",
      ImagePath: "assets/ocean.jpeg",
    ),
    Item(
      name: "Waterfall",
      audioPath: "meditation_audios/waterfall.mp3",
      ImagePath: "assets/waterfall.jpeg",
    ),
    Item(
      name: "Wind",
      audioPath: "meditation_audios/wind.mp3",
      ImagePath: "assets/wind.jpeg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].ImagePath),
                    ),
                  ),
                  child: ListTile(
                    title: Text(items[index].name),
                    leading: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {},
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
