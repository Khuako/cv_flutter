import 'package:dice/screens/dice_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(253, 165, 164, 1),
      ),
      home: diceScreen(),
    );
  }
}
