import 'package:flutter/material.dart';
import 'package:plants/ui/on_boarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Экран входа',
      theme: ThemeData(),
      home: const OnBoardingPage(),
    );
  }
}
