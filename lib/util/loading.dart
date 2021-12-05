import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'constant.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white60,
      child: Center(
          child: Column(
        children: [
          Lottie.asset('assets/lottieanimate/loading.json'),
          Text("Loading...",
              style:
                  GoogleFonts.montserrat(fontSize: 50, color: kPrimaryColor)),
        ],
      )),
    );
  }
}
