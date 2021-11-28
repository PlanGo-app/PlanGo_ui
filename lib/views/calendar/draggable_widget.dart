import 'package:flutter/material.dart';
import 'package:plango_front/model/item_model.dart';

class DraggableWidget extends StatelessWidget {
  final Marker marker;

  const DraggableWidget({
    Key? key,
    required this.marker,
  }) : super(key: key);

  static double size = 100;

  @override
  Widget build(BuildContext context) => LongPressDraggable<Marker>(
        data: marker,
        feedback: buildImage(150.0),
        child: buildImage(size),
        childWhenDragging: Container(
          height: size,
        ),
      );

  Widget buildImage(double width) => Container(
        height: size,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.blue,
        ),
        child: Center(
            child: Text(
          marker.name,
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
