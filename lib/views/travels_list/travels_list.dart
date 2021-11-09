import 'package:flutter/material.dart';
import 'package:plango_front/views/travels_list/travels_list_background.dart';

class TravelsList extends StatefulWidget {
  const TravelsList({Key? key}) : super(key: key);

  @override
  _TravelsListState createState() => _TravelsListState();
}

class _TravelsListState extends State<TravelsList> {
  @override
  Widget build(BuildContext context) {
    return BackgroundTravelsList(
        child: Container(
          color: Colors.purple,
          width: 100,
          height: 100,
        )
    );
  }
}
