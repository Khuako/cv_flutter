// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class diceScreen extends StatefulWidget {
  @override
  State<diceScreen> createState() => _diceScreenState();
}

class _diceScreenState extends State<diceScreen> {
  String? firstCube;
  String? secondCube;
  List<Image> playingCubes = [];
  final List<String> allCubes = [
    "diceImage/dice1.png",
    "diceImage/dice2.png",
    "diceImage/dice3.png",
    "diceImage/dice4.png",
    "diceImage/dice5.png",
    "diceImage/dice6.png",
  ];
  void rollCubes() {
    setState(() {
      playingCubes = [];
    });
    Random random = Random();
    String c1 = allCubes[random.nextInt(allCubes.length)];
    String c2 = allCubes[random.nextInt(allCubes.length)];
    firstCube = c1;
    secondCube = c2;
    playingCubes.add(Image.asset(firstCube!));
    playingCubes.add(Image.asset(secondCube!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 350,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: playingCubes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: playingCubes[index],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "ROLL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(
                      221,
                      81,
                      80,
                      1,
                    ),
                  ),
                ),
                onPressed: () {
                  rollCubes();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
