import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:plango_front/model/travel.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/sharing/sharing_page.dart';
import 'package:plango_front/views/travels_list/travels_list_background.dart';

class TravelsList extends StatefulWidget {
  const TravelsList({Key? key}) : super(key: key);

  @override
  _TravelsListState createState() => _TravelsListState();
}

class _TravelsListState extends State<TravelsList> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return BackgroundTravelsList(
        child: SizedBox(
          width: size.width * 0.95,
          height: size.height * 0.65,
          child: Container(
            decoration:
            BoxDecoration(border: Border.all(color: kPrimaryLightColor)),
            child: Scaffold(
              backgroundColor: Colors.white60,
              body: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: FutureBuilder<List<Travel>>(
                  future: loadTravels(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<Travel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: kPrimaryLightColor,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.data!.isEmpty) {
                          return const Text('No travels');
                        } else {
                          // return Text(snapshot.data!);
                          return TravelsListBuilder(
                              dateFormat: dateFormat, snapshot: snapshot);
                        }
                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }

  Future<String> _loadTravelsAssets() async {
    return await rootBundle
        .loadString('assets/travels.json'); // return your response
  }

  Future<List<Travel>> loadTravels() async {
    await Future.delayed(const Duration(seconds: 1), () => {});
    String jsonString = await _loadTravelsAssets();
    final jsonResponse = json.decode(jsonString);
    List<Travel> travels = [];
    for (dynamic travel in jsonResponse) {
      travels.add(Travel.fromJson(travel));
    }
    return travels;
  }
}

class TravelsListBuilder extends StatelessWidget {
  const TravelsListBuilder({
    Key? key,
    required this.dateFormat,
    required this.snapshot,
  }) : super(key: key);

  final DateFormat dateFormat;
  final AsyncSnapshot<List<Travel>> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Container(
            color: kPrimaryColor,
            margin: const EdgeInsets.only(bottom: 1.0),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index].name + " ( " + snapshot.data![index].country + " )",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        dateFormat.format(snapshot.data![index].date_start) +
                            " -- " +
                            dateFormat.format(snapshot.data![index].date_end),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              SharingPage(name: snapshot.data![index].name),
                        ));
                  },
                ),
              ],
            ),
          );
        });
  }
}
