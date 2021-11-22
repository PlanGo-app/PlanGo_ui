import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
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
        FutureBuilder<List<Place>>(
            future: getPlaces(searchController.text),
            builder:
                (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
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
                            tileColor: Colors.purple,
                            title: Text(snapshot.data![index].displayName),
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
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black, width: 2))),
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<NavBarBloc>().emit(NavBarInitial());
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

  getPlaces(text) {
    return Nominatim.searchByName(
      query: text,
      limit: 5,
      addressDetails: true,
      extraTags: false,
      nameDetails: true,
    );
  }
}
