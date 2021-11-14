import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/travels_list/travels_list_background.dart';
import 'package:share/share.dart';

class SharingPage extends StatelessWidget {
  const SharingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return BackgroundTravelsList(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 240,
                      child: Card(
                        child: TextFormField(
                          initialValue: "Code de partage",
                          readOnly: true,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(
                                  const ClipboardData(text: "Code de partage"))
                              .then(
                            (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Code copié")));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RoundedButton(
                          text: "Retour",
                          press: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: RoundedButton(
                          text: "Partager",
                          press: () {
                            Share.share("Plango: Code a partager");
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
