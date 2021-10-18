import 'package:flutter/material.dart';
class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //total height & width of screen
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 90,
              child: Image.asset("assets/image/plango_logo.png",width: size.width * 0.67)
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/image/deco_welcome_page_1.png", width: size.width * 1.1,)
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/image/deco_welcome_page_2.png", width: size.width * 1.2,)
          ),
          child,
        ],
      ),
    );
  }
}
