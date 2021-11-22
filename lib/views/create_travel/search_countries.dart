import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plango_front/model/country.dart';

class TextSearchCountry extends StatefulWidget {
  final TextEditingController searchController;
  final String address;
  const TextSearchCountry(
      {required this.searchController, required this.address, Key? key})
      : super(key: key);

  @override
  _TextSearchCountryState createState() => _TextSearchCountryState();
}

class _TextSearchCountryState extends State<TextSearchCountry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.searchController.text.isNotEmpty
            ? ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: FutureBuilder<List<Country>?>(
                      future: getCountry(
                          widget.searchController.text, widget.address),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Country>?> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.data!.isEmpty) {
                              return const Text('Pas de pays de ce nom');
                            } else {
                              return ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(snapshot.data![index].name),
                                      onTap: () {
                                        // context.read<CreateTravelBloc>().emit(
                                        //     CreateTravelSearch(snapshot.data![index]));
                                        // context.read<NavBarBloc>().emit(
                                        //     NavBarPlaceFound(snapshot.data![index]));
                                        // print(snapshot.data![index].name);
                                        widget.searchController.text =
                                            snapshot.data![index].name;
                                      },
                                    );
                                  });
                            }
                        }
                      }),
                ),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white),
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  getCountry(widget.searchController.text, widget.address);
                },
                child: const Icon(Icons.search_outlined),
                mini: true,
              ),
              Flexible(
                  child: TextField(
                autofocus: true,
                controller: widget.searchController,
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

  Future<List<Country>?> getCountry(text, address) async {
    late List<Country> countries;
    countries = [];
    try {
      var response = await Dio().get('$address$text',
          options: Options(responseType: ResponseType.plain));
      final jsonResponse = json.decode(response.data.toString());
      for (dynamic country in jsonResponse) {
        countries.add(Country.fromJson(Map<String, dynamic>.from(country)));
      }
    } catch (e) {
      print(e);
    }
    return countries;
  }
}
