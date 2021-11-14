import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/travels_list/travels_list_background.dart';
import 'package:share/share.dart';

class SharingPage extends StatelessWidget {
  final String name;

  const SharingPage({Key? key, required this.name}) : super(key: key);

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
                          initialValue: utf8.fuse(base64).encode(name),
                          readOnly: true,
                          showCursor: true,
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
                          Clipboard.setData(ClipboardData(
                                  text: utf8.fuse(base64).encode(name)))
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: RoundedButton(
                          text: "Retour",
                          press: () {
                            Navigator.pop(context);
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: RoundedButton(
                          text: "Partager",
                          press: () {
                            Share.share("http://Plango/VG9reW8=");
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
