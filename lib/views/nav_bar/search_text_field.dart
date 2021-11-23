import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          searchController.text.isNotEmpty
              ? FutureBuilder<List<Place>>(
                  future: getPlaces(searchController.text),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Place>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data!.isEmpty) {
                          return const Text(
                              'Aucun lieu ne correspond à votre recherche');
                        } else {
                          return ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 350),
                            child: ListView.separated(
                                primary: false,
                                separatorBuilder: (context, _) => const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title:
                                        Text(snapshot.data![index].displayName),
                                    onTap: () {
                                      context.read<NavBarBloc>().emit(
                                          NavBarPlaceFound(
                                              snapshot.data![index]));
                                    },
                                  );
                                }),
                          );
                        }
                    }
                  })
              : Container(),
          Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black, width: 2))),
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    context.read<NavBarBloc>().emit(NavBarInitial());
                  },
                  child: const Icon(Icons.more_horiz_outlined),
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
      ),
    );
  }

  getPlaces(text) {
    return Nominatim.searchByName(
      query: text,
      language: "fr",
      limit: 5,
      addressDetails: false,
      extraTags: false,
      nameDetails: false,
    );
  }
}
