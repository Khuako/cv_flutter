// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidget();
}

class _MainScreenWidget extends State<MainScreenWidget> {
  int _selectedIndex = 0;

  void onSelectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TMDB"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Новости',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.movie), label: 'Фильмы'),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.tv,
            ),
            label: 'Сериалы',
          ),
        ],
        onTap: (index) {
          onSelectTab(index);
        },
      ),
    );
  }
}
