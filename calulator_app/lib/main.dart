import 'package:calulator_app/model.dart';
import 'package:calulator_app/screens/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CalculatorModel? model = CalculatorModel();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: CalculatorModelProvider(
        model: model!,
        child: CalculatorScreen(),
      ),
    );
  }
}
