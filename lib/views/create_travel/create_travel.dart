import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:plango_front/model/city.dart';
import 'package:plango_front/model/country.dart';
import 'package:plango_front/service/travel_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account_background.dart';
import 'package:plango_front/views/create_travel/search_cities.dart';
import 'package:plango_front/views/create_travel/search_countries.dart';
import 'package:plango_front/views/screen/screen.dart';

class CreateTravel extends StatefulWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  _CreateTravelState createState() => _CreateTravelState();
}

class _CreateTravelState extends State<CreateTravel> {
  final _formKey = GlobalKey<FormState>();
  Country? country;
  City? city;
  bool? datePicked;
  bool? dateEndPicked;
  DateTime selectedDate = DateTime.now();
  late DateTime selectedEndDate = DateTime.now();

  final searchControllerCountry = TextEditingController();
  final searchControllerCity = TextEditingController();

  @override
  void initState() {
    country =
        Country(name: "", latlng: "", code: "", add_flag: "", realName: "");
    city = City(name: "", latlng: LatLng(0, 0));
    datePicked = false;
    dateEndPicked = false;
    selectedDate = DateTime.now();
    selectedEndDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context, bool isEndDate) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: (isEndDate ? selectedDate : DateTime.now()),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          if (!isEndDate) {
            selectedDate = picked;
            datePicked = true;
            print(selectedDate);
          } else {
            selectedEndDate = picked;
            dateEndPicked = true;
            print("aaaaaaaaaaaaaa ");
            print(selectedEndDate);
          }
        });
      }
    }

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
                              size: 40,
                              res: country!.name,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: SvgPicture.network(
                                  country!.add_flag,
                                  // placeholderBuilder: (context) =>
                                  //     const Loading(),
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
                                        country!.realName
                                            .replaceAll(" ", "%20") +
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
                              size: 40,
                              res: city!.name,
                              child: city!.name != ""
                                  ? const RoundedIcon(
                                      child: Icon(
                                      Icons.location_city,
                                      size: 30,
                                    ))
                                  : Container(),
                            ),
                      city!.name != "" && datePicked == false
                          ? Container(
                              width: 240,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      _selectDate(context, false);
                                    },
                                    child: const Icon(Icons.date_range),
                                    mini: true,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  TextInputDate(),
                                ],
                              ),
                            )
                          : Container(),
                      datePicked == true
                          ? ObjectTextDisplay(
                              res: selectedDate.day.toString() +
                                  "/" +
                                  selectedDate.month.toString() +
                                  "/" +
                                  selectedDate.year.toString() +
                                  " -> " +
                                  (dateEndPicked == true
                                      ? selectedEndDate.day.toString() +
                                          "/" +
                                          selectedEndDate.month.toString() +
                                          "/" +
                                          selectedEndDate.year.toString()
                                      : ""),
                              size: 20,
                              child: const RoundedIcon(
                                  child: Icon(
                                Icons.calendar_today,
                                size: 30,
                              )))
                          : Container(),
                      datePicked == true && dateEndPicked == false
                          ? Container(
                              width: 240,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      _selectDate(context, true);
                                    },
                                    child: const Icon(Icons.date_range),
                                    mini: true,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  TextInputDate(),
                                ],
                              ),
                            )
                          : Container(),
                      dateEndPicked == true
                          ? RoundedButton(
                              press: () {
                                TravelService()
                                    .addTravel(country!.name, city!.name,
                                        selectedDate, selectedEndDate)
                                    .then((value) => {
                                          value
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (
                                                      context,
                                                    ) =>
                                                        Screen(
                                                      city: city!.name,
                                                      country: country!.name,
                                                      date: selectedDate,
                                                      endDate: selectedEndDate,
                                                    ),
                                                  ))
                                              : print("error")
                                        });
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

  Flexible TextInputDate() {
    return Flexible(
        child: TextField(
      enabled: false,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      // controller: widget.searchController,
      onChanged: (text) {
        setState(() {});
        // getPlaces(searchController.text);
      },
    ));
  }
}

class RoundedIcon extends StatelessWidget {
  final Widget child;
  const RoundedIcon({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(105),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      child: child,
    );
  }
}

// ignore: must_be_immutable
class ObjectTextDisplay extends StatelessWidget {
  Widget child;
  double? size;
  ObjectTextDisplay({
    Key? key,
    required this.res,
    required this.child,
    required this.size,
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
              style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
