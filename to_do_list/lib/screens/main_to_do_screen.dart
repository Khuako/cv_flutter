import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MainToDoScreen extends StatefulWidget {
  const MainToDoScreen({super.key});

  @override
  State<MainToDoScreen> createState() => _MainToDoScreenState();
}

class _MainToDoScreenState extends State<MainToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
    );
  }
}
