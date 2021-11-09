import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';
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
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple)
          ),
          width: 200,
          height: 300,
          child: Scaffold(
            body: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                child: ListView.builder(
                  itemCount: ["voyage1","voyage2"].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(["voyage1", "voyage2"][index]),
                      tileColor: Colors.blue,
                    );
                  }),
              ),
          ),
          )
    );
  }
}
