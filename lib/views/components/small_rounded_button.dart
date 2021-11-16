import 'package:flutter/material.dart';
import 'package:plango_front/util/constant.dart';

class SmallRoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  const SmallRoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      // height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: TextButton(
            onPressed: press,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              backgroundColor: kPrimaryColor,
            ),
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 15))),
      ),
    );
  }
}
