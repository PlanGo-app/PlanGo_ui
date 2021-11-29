import 'package:flutter/material.dart';
import 'package:plango_front/model/item_model.dart';
import 'package:plango_front/service/planning_event_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'draggable_widget.dart';

class Calendar extends StatefulWidget {
  late List<Marker> all = [];
  late Map<String, Marker?> plan = {};
  Calendar({Key? key}) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final _scrollController = ItemScrollController();
  final double size = 100;
  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _scrollController.jumpTo(index: 8));
    widget.all = [];
    widget.plan = {};
    PlanningEventService().loadMarkers().then((value) {
      setState(() {
        for (int i = 0; i < 24; i++) {
          widget.plan[i.toString().padLeft(2, '0') + "h00"] = null;
        }
        widget.all = value;
      });
    });
    super.initState();
  }

  void removeAll(Marker toRemove) {
    widget.all.removeWhere((marker) => marker.name == toRemove.name);
    widget.plan.forEach((key, value) {
      if (value != null && value.name == toRemove.name) {
        widget.plan[key] = null;
      }
    });
  }

  bool isInAll(Marker toCheck) {
    return widget.all.contains(toCheck);
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: buildTarget(
                  context,
                  text: 'Activités',
                  markers: widget.all,
                  onAccept: (data) => setState(() {
                    removeAll(data);
                    widget.all.add(data);
                  }),
                  onData: (data) => isInAll(data),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    height: sizeScreen.height * 0.6,
                    width: sizeScreen.width * 0.85,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: 24,
                      itemBuilder: (context, index) {
                        return buildTarget(
                          context,
                          text: index.toString().padLeft(2, '0') + 'h00',
                          markers: widget
                              .plan[index.toString().padLeft(2, '0') + 'h00'],
                          onAccept: (data) => setState(() {
                            if (widget.plan[
                                    index.toString().padLeft(2, '0') + 'h00'] ==
                                null) {
                              removeAll(data);
                              widget.plan[index.toString().padLeft(2, '0') +
                                  'h00'] = data;
                            }
                          }),
                          onData: (data) => isInAll(data),
                        );
                      },
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTarget(
    BuildContext context, {
    required String text,
    required dynamic markers,
    required DragTargetAccept<Marker> onAccept,
    required bool Function(dynamic) onData,
  }) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Expanded(flex: 2, child: Container(child: Center(child: Text(text)))),
          Expanded(
            flex: 8,
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black))),
              height: 65,
              child: DragTarget<Marker>(
                builder: (context, candidateData, rejectedData) => ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (markers is List<Marker>) ...[
                      ...markers
                          .map((marker) =>
                              DraggableWidget(onData: onData, marker: marker))
                          .toList(),
                      // IgnorePointer(child: Center(child: buildText(text))),
                    ] else ...[
                      DraggableWidget(onData: onData, marker: markers)
                    ]
                  ],
                ),
                onWillAccept: (data) => true,
                onAccept: (data) {
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
