import 'package:flutter/material.dart';
import 'package:hive_example/example_widget_model.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ExampleWidgetModel();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              model.doSome();
            },
            child: const Text('Жми меня'),
          ),
        ),
      ),
    );
  }
}
