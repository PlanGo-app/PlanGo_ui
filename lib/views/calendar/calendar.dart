import 'package:flutter/material.dart';
import 'package:plango_front/model/item_model.dart';

import 'draggable_widget.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final List<Animal> all = allAnimals;
  final List<Animal> land = [];
  final List<Animal> air = [];

  final double size = 150;

  void removeAll(Animal toRemove) {
    all.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    land.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
    air.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
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
                  text: 'All',
                  animals: all,
                  acceptTypes: AnimalType.values,
                  onAccept: (data) => setState(() {
                    removeAll(data);
                    all.add(data);
                  }),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildTarget(
                    context,
                    text: '08h00',
                    animals: land,
                    acceptTypes: [AnimalType.land],
                    onAccept: (data) => setState(() {
                      removeAll(data);
                      land.add(data);
                    }),
                  ),
                  buildTarget(
                    context,
                    text: '10h00',
                    animals: air,
                    acceptTypes: [AnimalType.air],
                    onAccept: (data) => setState(() {
                      removeAll(data);
                      air.add(data);
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildTarget(
    BuildContext context, {
    required String text,
    required List<Animal> animals,
    required List<AnimalType> acceptTypes,
    required DragTargetAccept<Animal> onAccept,
  }) =>
      Container(
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
                child: DragTarget<Animal>(
                  builder: (context, candidateData, rejectedData) => Row(
                    children: [
                      ...animals
                          .map((animal) => DraggableWidget(animal: animal))
                          .toList(),
                      // IgnorePointer(child: Center(child: buildText(text))),
                    ],
                  ),
                  onWillAccept: (data) => true,
                  onAccept: (data) {
                    if (acceptTypes.contains(data.type)) {
                      print("accept");
                    } else {
                      print("accept");
                    }

                    onAccept(data);
                  },
                ),
              ),
            ),
          ],
        ),
      );

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
