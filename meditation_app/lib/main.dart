import 'package:flutter/material.dart';
import 'package:meditation_app/screens/meditation_app_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home:MeditationAppScreen(),
    );
  }
}
