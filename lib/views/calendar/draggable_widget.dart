import 'package:flutter/material.dart';
import 'package:plango_front/model/item_model.dart';

class DraggableWidget extends StatelessWidget {
  final Marker? marker;

  bool Function(dynamic) onData;

  DraggableWidget({Key? key, required this.marker, required this.onData})
      : super(key: key);

  static double size = 100;

  @override
  Widget build(BuildContext context) => LongPressDraggable<Marker>(
        data: marker,
        feedback: buildImage(150.0, context),
        child: buildImage(size, context),
        childWhenDragging: Container(
          height: size,
        ),
      );

  Widget buildActivities(double width) => marker == null
      ? Container()
      : Container(
          width: width,
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.green,
          ),
          child: Center(
              child: Text(
            marker!.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal),
          )),
        );

  Widget buildImage(double width, BuildContext context) => marker == null
      ? Container()
      : onData.call(marker)
          ? buildActivities(width)
          : Container(
              width: MediaQuery.of(context).size.width * .8,
              // width: double.infinity,

              color: Colors.blueGrey,
              child: Center(
                  child: Text(
                marker!.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              )),
            );
}
