import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:plango_front/model/city.dart';
import 'package:plango_front/util/constant.dart';

class TextSearchCity extends StatefulWidget {
  final TextEditingController searchController;
  final String address;
  final Function(City) search;

  const TextSearchCity(
      {required this.searchController,
      required this.address,
      Key? key,
      required this.search})
      : super(key: key);

  @override
  _TextSearchCityState createState() => _TextSearchCityState();
}

class _TextSearchCityState extends State<TextSearchCity> {
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
                  child: FutureBuilder<List<City>?>(
                      future:
                          getCity(widget.searchController.text, widget.address),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<City>?> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.data!.isEmpty) {
                              return const Text('Pas de ville de ce nom');
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
                                          title:
                                              Text(snapshot.data![index].name),
                                          onTap: () {
                                            // widget.searchController.text =
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
                  getCity(widget.searchController.text, widget.address);
                },
                child: const Icon(Icons.search_outlined),
                mini: true,
                backgroundColor: kPrimaryColor,
              ),
              Flexible(
                  child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
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

  Future<List<City>?> getCity(text, address) async {
    late List<City> cities;
    cities = [];
    try {
      var result = await http.read(Uri.parse(address + text));
      var builder = result.substring(1, result.length - 1).split(',');
      if (result.contains("error")) {
        return [];
      }
      for (var elm in builder) {
        cities.add(
            City(name: elm.substring(1, elm.length - 1), latlng: LatLng(0, 0)));
      }
    } catch (e) {
      print(e);
    }
    return cities;
  }
}
