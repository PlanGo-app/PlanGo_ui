import 'package:flutter/material.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account_background.dart';
import 'package:plango_front/views/create_travel/search_countries.dart';
import 'package:plango_front/views/map_page/map_page.dart';

class CreateTravel extends StatefulWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  _CreateTravelState createState() => _CreateTravelState();
}

class _CreateTravelState extends State<CreateTravel> {
  final _formKey = GlobalKey<FormState>();
  String? pseudo;
  String? email;
  final searchControllerCountry = TextEditingController();
  final searchControllerCity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return BackgroundCreateAccount(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: TextSearchCountry(
                          searchController: searchControllerCountry,
                          address: "https://restcountries.com/v3.1/name/",
                        ),

                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //       label:
                        //           Text("Dans quel pays allez-vous voyager ?")),
                        //   // The validator receives the text that the user has entered.
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter some text';
                        //     }
                        //     return null;
                        //   },
                        //   onSaved: (value) {
                        //     pseudo = value;
                        //   },
                        // ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextSearchCountry(
                          searchController: searchControllerCity,
                          address:
                              "https://restcountries.com/v3.1/translation/",
                        ),
                      ),
                      RoundedButton(
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                  context,
                                ) =>
                                    const MapPage(),
                              ));
                          // print(searchControllerCountry.text);
                        },
                        text: "Créer",
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
