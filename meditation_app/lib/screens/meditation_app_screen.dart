import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      audioPath: "auds/forest.mp3",
      ImagePath: "assets/forest.jpeg",
    ),
    Item(
      name: "Night",
      audioPath: "auds/nightt.mp3",
      ImagePath: "assets/night.jpeg",
    ),
    Item(
      name: "Ocean",
      audioPath: "auds/ocean.mp3",
      ImagePath: "assets/ocean.jpeg",
    ),
    Item(
      name: "Waterfall",
      audioPath: "auds/waterfall.mp3",
      ImagePath: "assets/waterfall.jpeg",
    ),
    Item(
      name: "Wind",
      audioPath: "auds/wind.mp3",
      ImagePath: "assets/wind.jpeg",
    ),
  ];
  final AudioPlayer audioPlayer = AudioPlayer();

  int? playingIndex;

  // Widget showIcon(int currentIndex) {
  //   if (playingIndex == currentIndex) {
  //     return FaIcon(FontAwesomeIcons.stop);
  //   } else
  //     return FaIcon(FontAwesomeIcons.play);
  // }

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
                        icon: playingIndex == index
                            ? FaIcon(FontAwesomeIcons.stop)
                            : FaIcon(FontAwesomeIcons.play),
                        onPressed: () async {
                          if (playingIndex == index) {
                            setState(() {
                              playingIndex = null;
                            });
                            audioPlayer.stop();
                          } else {
                            try {
                              await audioPlayer
                                  .setAsset(items[index].audioPath)
                                  .catchError((onError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Oops... an error has occured"),
                                  ),
                                );
                              });
                              audioPlayer.play();
                              setState(() {
                                playingIndex = index;
                              });
                            } catch (error) {
                              print(error);
                            }
                          }
                        }),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
