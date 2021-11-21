import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plango_front/model/country.dart';

class TextSearchCountry extends StatefulWidget {
  const TextSearchCountry({Key? key}) : super(key: key);

  @override
  _TextSearchCountryState createState() => _TextSearchCountryState();
}

class _TextSearchCountryState extends State<TextSearchCountry> {
  final searchController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   getCountry("fra");
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<List<Country>?>(
            future: getCountry(searchController.text),
            builder:
                (BuildContext context, AsyncSnapshot<List<Country>?> snapshot) {
              print(snapshot.data);
              print(snapshot.connectionState);
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Text('Pas de pays de ce nom');
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                            // onTap: () {
                            //   context.read<NavBarBloc>().emit(
                            //       NavBarPlaceFound(snapshot.data![index]));
                            // },
                          );
                        });
                  }
              }
            }),
        Container(
          color: Colors.transparent,
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  // context
                  // .read<NavBarBloc>()
                  // .add(NavBarEventPlaceFound(place: Place()));
                },
                child: const Icon(Icons.search_outlined),
                mini: true,
              ),
              Flexible(
                  child: TextField(
                autofocus: true,
                controller: searchController,
                onChanged: (text) {
                  setState(() {});
                  // getPlaces(searchController.text);
                },
              )),
            ],
          ),
        ),
      ],
    );
    // return Container();
  }

  Future<List<Country>?> getCountry(text) async {
    late List<Country> countries;
    countries = [];
    try {
      var response = await Dio().get(
          'https://restcountries.com/v3.1/name/$text',
          options: Options(responseType: ResponseType.plain));
      final jsonResponse = json.decode(response.data.toString());
      for (dynamic country in jsonResponse) {
        print(country.runtimeType);
        print(Country.fromJson(Map<String, dynamic>.from(country)));
        countries.add(Country.fromJson(Map<String, dynamic>.from(country)));
      }
    } catch (e) {
      print(e);
    }
    return countries;
  }
}
