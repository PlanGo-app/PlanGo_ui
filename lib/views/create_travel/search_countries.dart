import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plango_front/model/country.dart';
import 'package:plango_front/util/constant.dart';

class TextSearchCountry extends StatefulWidget {
  final TextEditingController searchController;
  final String address;
  final Function(Country) search;

  const TextSearchCountry(
      {required this.searchController,
      required this.address,
      Key? key,
      required this.search})
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
                              return MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: SvgPicture.network(
                                                  snapshot
                                                      .data![index].add_flag,
                                                  width: 20,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  snapshot.data![index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                          onTap: () {
                                            // widget.searchController.text =
                                            //     snapshot.data![index].name;
                                            widget
                                                .search(snapshot.data![index]);
                                          },
                                        );
                                      }));
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
                backgroundColor: kPrimaryColor,
              ),
              Flexible(
                  child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Dans quel pays ?',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
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
