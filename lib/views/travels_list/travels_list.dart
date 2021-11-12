import 'package:flutter/material.dart';
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
    return BackgroundTravelsList(
        child: SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.85,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
        child: Scaffold(
          backgroundColor: Colors.blue,
          // decoration: BoxDecoration(border: Border.all(color: Colors.deepPurple)),
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: ["voyage1", "voyage2"].length,
                itemBuilder: (context, index) {
                  return Row(
                    // title: Text(["voyage1", "voyage2"][index]),
                    // tileColor: Colors.blue
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ["voyage1", "voyage2"][index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          print("Share");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SharingPage(),
                              ));
                        },
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    ));
  }
}
