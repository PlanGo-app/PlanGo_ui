import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/input.dart';
import 'package:plango_front/views/components/label.dart';

class Field extends StatelessWidget {
  final String text;
  final Color color;
  const Field({
    Key? key, required this.text, required this.color,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Label(text: text, color: color),
        const Input(),
      ],
    );
  }
}