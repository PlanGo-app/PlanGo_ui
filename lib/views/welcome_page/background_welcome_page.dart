import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/views/welcome_page/welcome_page_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Background extends StatefulWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackgroundState();


}


class _BackgroundState extends State<Background>{
  @override
  void initState() {
    super.initState();

    KeyboardVisibilityController().onChange.listen((isVisible) {
     if(isVisible)
      context.read<WelcomePageBloc>().add(const NotTypingEvent());
     else
      context.read<WelcomePageBloc>().add(const TypingEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size; //total height & width of screen
    return BlocBuilder<WelcomePageBloc, WelcomePageState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {

          return SizedBox(
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
                if(state is NotTyping) ...[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset("assets/image/deco_welcome_page_1.png",
                        width: size.width * 0.9,)
                  ),
                ],
                if(state is Typing) ...[
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset("assets/image/deco_welcome_page_2.png",
                        width: size.width * 1.2,)
                  ),

                ],
                widget.child,


              ],
            ),
          );
        });
  }
}