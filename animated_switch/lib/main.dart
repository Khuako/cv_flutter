import 'package:animated_switch/provider_switch.dart';
import 'package:animated_switch/switch_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider<ProviderSwitch>.value(
          value: ProviderSwitch(),
        ),
      ], child: SwitchAnimation()),
    );
  }
}
