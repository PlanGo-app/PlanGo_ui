import 'package:flutter/material.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/travels_list/travels_list_background.dart';

class SharingPage extends StatelessWidget {
  const SharingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundTravelsList(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: Container(
              color: Colors.redAccent,
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.blueAccent,
                  // height: double.infinity,
                  width: MediaQuery.of(context).size.width / 2,
                  child: RoundedButton(
                      text: "Retour",
                      press: () {
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  // color: Colors.green,
                  // height: double.infinity,
                  width: MediaQuery.of(context).size.width / 2,
                  child: RoundedButton(
                      text: "Partager",
                      press: () {
                        print("Partager");
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
