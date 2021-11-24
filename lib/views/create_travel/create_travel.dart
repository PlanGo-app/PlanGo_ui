import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plango_front/model/city.dart';
import 'package:plango_front/model/country.dart';
import 'package:plango_front/util/loading.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account_background.dart';
import 'package:plango_front/views/create_travel/search_cities.dart';
import 'package:plango_front/views/create_travel/search_countries.dart';
import 'package:plango_front/views/map_page/map_page.dart';

class CreateTravel extends StatefulWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  _CreateTravelState createState() => _CreateTravelState();
}

class _CreateTravelState extends State<CreateTravel> {
  final _formKey = GlobalKey<FormState>();
  Country? country;
  City? city;
  final searchControllerCountry = TextEditingController();
  final searchControllerCity = TextEditingController();

  @override
  void initState() {
    country = Country(name: "", latlng: "", code: "", add_flag: "");
    city = City(name: "", latlng: "");
    super.initState();
  }

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
                      country!.name == ""
                          ? SizedBox(
                              width: 240,
                              child: TextSearchCountry(
                                searchController: searchControllerCountry,
                                address: "https://restcountries.com/v3.1/name/",
                                search: (res) {
                                  searchControllerCountry.text = res.name;
                                  setState(() {
                                    country = res;
                                  });
                                },
                              ),
                            )
                          : ObjectTextDisplay(
                              res: country!.name,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.network(
                                  country!.add_flag,
                                  placeholderBuilder: (context) =>
                                      const Loading(),
                                  width: 30,
                                ),
                              ),
                            ),
                      country!.name != "" && city!.name == ""
                          ? SizedBox(
                              width: 240,
                              child: TextSearchCity(
                                searchController: searchControllerCity,
                                address:
                                    "https://shivammathur.com/countrycity/cities/" +
                                        searchControllerCountry.text +
                                        "/",
                                search: (res) {
                                  searchControllerCity.text = res.name;
                                  setState(() {
                                    city = res;
                                  });
                                },
                              ),
                            )
                          : ObjectTextDisplay(
                              res: city!.name,
                              child: city!.name != ""
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(105),
                                      ),
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.location_city,
                                        size: 30,
                                      ),
                                    )
                                  : Container(),
                            ),
                      city!.name != ""
                          ? RoundedButton(
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
                          : Container(),
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

class ObjectTextDisplay extends StatelessWidget {
  Widget child;
  ObjectTextDisplay({
    Key? key,
    required this.res,
    required this.child,
  }) : super(key: key);

  final String? res;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            Text(
              res!,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
