import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final Color color;
  const Label({
    Key? key, required this.text, required this.color,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(color: color, fontSize: 15),
    );
  }
}
