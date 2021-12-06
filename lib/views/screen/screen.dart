import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/group_travel/group_travel.dart';
import 'package:plango_front/views/map_page/map_page.dart';
import 'package:plango_front/views/syncfusion/syncfusion_test.dart';

class Screen extends StatefulWidget {
  final String city;
  final String country;
  final DateTime date;
  final DateTime endDate;
  final int travelId;
  const Screen(
      {Key? key,
      required this.city,
      required this.country,
      required this.date,
      required this.endDate,
      required this.travelId})
      : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _currentIndex = 1;
  late List _children;
  @override
  // ignore: must_call_super
  void initState() {
    _children = [
      Group(
        travelId: widget.travelId,
      ),
      MapPage(
        country: widget.country,
        city: widget.city,
        travelId: widget.travelId,
      ),
      SyncfusionTest(
        dateBegin: widget.date,
        dateEnd: widget.endDate,
        travelId: widget.travelId,
      ),
    ];
  }

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
                icon: const Icon(Icons.group),
                title: const Text('Groupe'),
                textAlign: TextAlign.center,
                activeColor: kPrimaryLightColor,
                inactiveColor: kPrimaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.map),
                title: const Text('Map'),
                textAlign: TextAlign.center,
                activeColor: kPrimaryLightColor,
                inactiveColor: kPrimaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.calendar_today),
                title: const Text('Calendrier'),
                activeColor: kPrimaryLightColor,
                textAlign: TextAlign.center,
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
