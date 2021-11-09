import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundTravelsList extends StatefulWidget {
  final Widget child;

  const BackgroundTravelsList({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackgroundTravelsListState();


}


class _BackgroundTravelsListState extends State<BackgroundTravelsList>{

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size; //total height & width of screen
          return Container(
            color: Colors.white,
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: size.height * 0.03,
                  child: Image.asset(
                      "assets/image/plango_logo.png", width: size.width * 0.67),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset("assets/image/deco_welcome_page_1.png",
                      width: size.width * 0.9,)
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset("assets/image/deco_welcome_page_2.png",
                      width: size.width * 1.2,)
                ),
                widget.child,


              ],
            ),
          );
        }
  }
