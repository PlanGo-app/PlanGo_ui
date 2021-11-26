import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/views/nav_bar/nav_bar_bloc/nav_bar_bloc.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavBarBloc(),
      child: const Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List dragItems = [];
  Widget? widgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 3,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Draggable(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.red,
                ),
                feedback: Container(
                  height: 50,
                  width: 50,
                  color: Colors.green,
                ),
                childWhenDragging: Container(),
              ),
              Draggable(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.red,
                ),
                feedback: Container(
                  height: 50,
                  width: 50,
                  color: Colors.green,
                ),
                childWhenDragging: Container(),
                data: "Data",
              ),
              Draggable(
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.red,
                ),
                feedback: Container(
                  height: 50,
                  width: 50,
                  color: Colors.green,
                ),
                childWhenDragging: Container(),
              ),
            ],
          ),
          flex: 2,
        ),
        Expanded(
          child: Container(),
          flex: 3,
        ),
        Flexible(
          flex: 2,
          child: DragTarget(
            builder: (context, List<Object?> candidateData, rejectedData) {
              print(candidateData);
              return Container(
                width: 100,
                height: 100,
                color: candidateData.isEmpty ? Colors.blue : Colors.yellow,
                child: const Center(
                  child: Text(
                    "10h00",
                    style: TextStyle(color: Colors.black, fontSize: 22.0),
                  ),
                ),
              );
            },
            onWillAccept: (data) {
              print("WILL ACCEPT");
              print(data);
              return data == "Data";
            },
            onAccept: (Widget w) {
              print("ACCEPT");
              widgets = w;
            },
          ),
        ),
      ],
    );
  }
}
