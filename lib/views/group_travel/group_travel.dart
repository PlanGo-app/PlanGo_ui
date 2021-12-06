import 'package:flutter/material.dart';
import 'package:plango_front/model/user.dart';
import 'package:plango_front/service/travel_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/loading.dart';
import 'package:plango_front/views/components/warning_animation.dart';
import 'package:plango_front/views/travels_list/travels_list.dart';

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
                return Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListOfMembers(size, snapshot, _isAdmin),
                    ),
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        margin: const EdgeInsets.all(10),
                        child: TextButton.icon(
                          icon: const Icon(Icons.leave_bags_at_home,
                              size: 25, color: Colors.white),
                          onPressed: () {
                            AlertDialog alert = AlertDialog(
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    TravelService()
                                        .deleteTravel(widget.travelId)
                                        .then((value) => {
                                              if (value.statusCode != 200)
                                                {
                                                  showModalBottomSheet(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25)),
                                                      ),
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return WarningModal(
                                                          text:
                                                              "Impossible de quitter le voyage",
                                                          url_animation:
                                                              'assets/lottieanimate/error.json',
                                                        );
                                                      }),
                                                  // Navigator.of(context).pop(),
                                                  // Navigator.of(context).pop(),
                                                }
                                              else
                                                {
                                                  Navigator.of(context).pop(),
                                                  Navigator.of(context).pop(),
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (
                                                          context,
                                                        ) =>
                                                            TravelsList(),
                                                      )),
                                                }
                                            });
                                  },
                                  child: const Text(
                                    'Quitter le voyage',
                                    style: TextStyle(color: kPrimaryLightColor),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Annuler',
                                        style:
                                            TextStyle(color: kPrimaryColor))),
                              ],
                              title: const Text(
                                'Etes-vous sûr de vouloir quitter le voyage ?',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          label: const Text(
                            "QUITTER LE GROUPE",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  ListView ListOfMembers(
      Size size, AsyncSnapshot<List<User>> snapshot, bool _isAdmin) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return Container(
          color: kPrimaryColor,
          child: Container(
            width: size.height * 0.7,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Text(
                      snapshot.data![index].pseudo,
                      style: const TextStyle(fontSize: 60, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                _isAdmin && snapshot.data![index].pseudo != USER_NAME
                    ? Expanded(
                        flex: 2,
                        child: IconButton(
                            onPressed: () {
                              TravelService()
                                  .kickMember(
                                      snapshot.data![index].id, widget.travelId)
                                  .then((value) => {
                                        setState(() {}),
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight:
                                                      Radius.circular(25)),
                                            ),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return WarningModal(
                                                text: value.statusCode == 200
                                                    ? "Membre retiré"
                                                    : "Impossible de retirer ce membre",
                                                url_animation: value
                                                            .statusCode ==
                                                        200
                                                    ? 'assets/lottieanimate/done.json'
                                                    : 'assets/lottieanimate/error.json',
                                              );
                                            })
                                      });
                            },
                            icon: const Icon(
                              Icons.delete_forever_rounded,
                              size: 40,
                              color: Colors.white,
                            )))
                    : Container(),
                snapshot.data![index].pseudo == USER_NAME &&
                        snapshot.data![index].role == "ADMIN"
                    ? Flexible(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.looks_one,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      )
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
