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
        verticalDirection: VerticalDirection.up,
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
                                      context.read<NavBarBloc>().add(
                                          NavBarEventPlaceFound(
                                              place: snapshot.data![index]));
                                      searchController.text = "";
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
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
            child: Flexible(
                child: TextField(
              // autofocus: true,
              decoration: new InputDecoration(
                hintText: 'Votre recherche',
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(20),
              ),
              controller: searchController,

              onChanged: (text) {
                setState(() {});
                // getPlaces(searchController.text);
              },
            )),
          ),
        ],
      ),
    );
  }

  getPlaces(text) {
    return Nominatim.searchByName(
      query: text,
      limit: 5,
    );
  }
}
