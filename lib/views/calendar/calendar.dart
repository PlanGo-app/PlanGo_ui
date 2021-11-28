import 'package:flutter/material.dart';
import 'package:plango_front/model/item_model.dart';
import 'package:plango_front/service/planning_event_service.dart';

import 'draggable_widget.dart';

class Calendar extends StatefulWidget {
  late List<Marker> all = [];
  final List<Marker> land = [];
  final List<Marker> air = [];
  Calendar({Key? key}) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final double size = 100;
  @override
  void initState() {
    widget.all = [];
    PlanningEventService().loadMarkers().then((value) {
      setState(() {
        widget.all = value;
      });
    });
    super.initState();
  }

  void removeAll(Marker toRemove) {
    widget.all.removeWhere((marker) => marker.name == toRemove.name);
    widget.land.removeWhere((marker) => marker.name == toRemove.name);
    widget.air.removeWhere((marker) => marker.name == toRemove.name);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: buildTarget(
                  context,
                  text: 'Activités',
                  markers: widget.all,
                  onAccept: (data) => setState(() {
                    removeAll(data);
                    widget.all.add(data);
                  }),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return buildTarget(
                      context,
                      text: index.toString() + 'h00',
                      markers: widget.land,
                      onAccept: (data) => setState(() {
                        if (widget.land.isEmpty) {
                          removeAll(data);
                          widget.land.add(data);
                        }
                      }),
                    );
                  },
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTarget(
    BuildContext context, {
    required String text,
    required List<Marker> markers,
    required DragTargetAccept<Marker> onAccept,
  }) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(text)),
          Expanded(
            flex: 8,
            child: Container(
              height: 100,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.purple)),
              child: DragTarget<Marker>(
                builder: (context, candidateData, rejectedData) => ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...markers
                        .map((marker) => DraggableWidget(marker: marker))
                        .toList(),
                    // IgnorePointer(child: Center(child: buildText(text))),
                  ],
                ),
                onWillAccept: (data) => true,
                onAccept: (data) {
                  // if (acceptTypes.contains(data.type)) {
                  //   print("accept");
                  // } else {
                  //   print("accept");
                  // }

                  onAccept(data);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildText(String text) => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 12,
          )
        ]),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
