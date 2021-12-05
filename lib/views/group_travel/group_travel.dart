import 'package:flutter/material.dart';
import 'package:plango_front/model/user.dart';
import 'package:plango_front/service/travel_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/loading.dart';

class Group extends StatefulWidget {
  late int travelId;
  Group({Key? key, required this.travelId}) : super(key: key);

  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  late bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    _loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isAdmin = false;
    var size = MediaQuery.of(context).size;
    // TravelService().getMembers(widget.travelId).then((value) => {
    //       print(value),
    //       // setState(() {
    //       //   _loading = false;
    //       // })
    //     });

    return Container(
      color: Colors.deepPurple,
      child: FutureBuilder<List<User>>(
        future: TravelService().getMembers(widget.travelId),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Loading();
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(
                  child: Text(
                    'Impossible de recupérer les membres du voyage pour le moment',
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucun membre'));
              } else {
                for (var i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].pseudo == USER_NAME &&
                      snapshot.data![i].role == "ADMIN") {
                    _isAdmin = true;
                  }
                }
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue,
                      child: Container(
                        width: size.height * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Center(
                                child: Text(
                                  snapshot.data![index].pseudo,
                                  style: const TextStyle(
                                      fontSize: 60, color: Colors.red),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            _isAdmin
                                ? const Expanded(
                                    flex: 2,
                                    child: Icon(
                                      Icons.delete_forever_rounded,
                                      size: 40,
                                      color: Colors.white,
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              }
          }
        },
      ),
    );
  }
}
