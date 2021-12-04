import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  String title;
  ErrorText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              overflow: TextOverflow.ellipsis),
        ));
  }
}
