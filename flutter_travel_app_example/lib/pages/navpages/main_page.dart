import 'package:flutter/material.dart';
import 'package:flutter_travel_app_example/pages/navpages/bar_item_page.dart';
import 'package:flutter_travel_app_example/pages/home_page.dart';
import 'package:flutter_travel_app_example/pages/navpages/my_page.dart';
import 'package:flutter_travel_app_example/pages/navpages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    BarItemPage(),
    SearchPage(),
    MyPage(),
  ];
  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        currentIndex: curIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: (value) {
          setState(() {
            curIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.apps,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bar',
            icon: Icon(
              Icons.bar_chart_sharp,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            label: 'My',
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
