import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextButton(
            onPressed: press,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              backgroundColor: kPrimaryColor,
            ),
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 15))
        ),
      ),
    );
  }
}