import 'package:flutter/material.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:plango_front/util/constant.dart';
import 'package:provider/src/provider.dart';

import 'nav_bar_bloc/nav_bar_bloc.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<List<MapBoxPlace>>(
            future: getPlaces(searchController.text),
            builder: (BuildContext context,
                AsyncSnapshot<List<MapBoxPlace>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data!.isEmpty) {
                    return const Text('No travels');
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].toString()),
                            onTap: () {
                              context.read<NavBarBloc>().emit(
                                  NavBarPlaceFound(snapshot.data![index]));
                            },
                          );
                        });
                  }
              }
            }),
        Container(
          color: Colors.red,
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  context
                      .read<NavBarBloc>()
                      .add(NavBarEventPlaceFound(place: MapBoxPlace()));
                },
                child: Icon(Icons.more_horiz_outlined),
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
  }

  final placesSearch = PlacesSearch(
    apiKey: API_KEY,
    limit: 5,
  );

  Future<List<MapBoxPlace>> getPlaces(text) {
    return placesSearch.getPlaces(text);
  }
}
