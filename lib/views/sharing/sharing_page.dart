import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/small_rounded_button.dart';
import 'package:share/share.dart';

class SharingPage extends StatelessWidget {
  final String name;

  const SharingPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset("assets/image/plango_title.png"),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Label(
                                text: "Votre code Plango :",
                                color: kPrimaryLightColor),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            width: 240,
                            child: Card(
                              child: TextFormField(
                                initialValue: utf8.fuse(base64).encode(name),
                                readOnly: true,
                                showCursor: true,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: utf8.fuse(base64).encode(name)))
                                .then(
                              (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Code copié")));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: SmallRoundedButton(
                            text: "Retour",
                            press: () {
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                        child: SmallRoundedButton(
                            text: "Partager",
                            press: () {
                              Share.share("http://Plango/VG9reW8=");
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
