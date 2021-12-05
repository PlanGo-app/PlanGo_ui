import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plango_front/views/components/error_text.dart';

class WarningModal extends StatelessWidget {
  late String text;
  late String url_animation;
  WarningModal({
    required this.text,
    required this.url_animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 80,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Column(children: [
                    Expanded(flex: 10, child: Lottie.asset(url_animation)),
                    Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ErrorText(title: text),
                        )),
                  ])),
            ],
          ),
        ));
  }
}
