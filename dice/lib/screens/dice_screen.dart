// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class diceScreen extends StatefulWidget {
  @override
  State<diceScreen> createState() => _diceScreenState();
}

class _diceScreenState extends State<diceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
