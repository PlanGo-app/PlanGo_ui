import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/calendar/calendar.dart';
import 'package:plango_front/views/map_page/map_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _currentIndex = 0;
  final List _children = [
    const MapPage(),
    const Calendar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: _currentIndex,
          curve: Curves.easeOut,
          onItemSelected:
              onTabTapped, // this will be set when a new tab is tapped
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.map),
                title: const Text('Map'),
                activeColor: kPrimaryLightColor,
                inactiveColor: kPrimaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.calendar_today),
                title: const Text('Calendrier'),
                activeColor: kPrimaryLightColor,
                inactiveColor: kPrimaryColor),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
