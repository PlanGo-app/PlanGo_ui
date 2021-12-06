import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plango_front/model/travel.dart';
import 'package:plango_front/service/travel_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/small_rounded_button.dart';
import 'package:plango_front/views/components/warning_animation.dart';
import 'package:plango_front/views/screen/screen.dart';

class JoinPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  JoinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset("assets/image/plango_title.png"),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Label(
                                text: "code Plango :",
                                color: kPrimaryLightColor),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            width: 240,
                            child: Card(
                              child: TextFormField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: SmallRoundedButton(
                            text: "Retour",
                            press: () {
                              Navigator.pop(context);
                            }),
                      ),
                      SizedBox(
                        child: SmallRoundedButton(
                            text: "Rejoindre",
                            press: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              TravelService()
                                  .joinTravel(controller.text)
                                  .then((value) => {
                                        if (value is Travel)
                                          {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Screen(
                                                        travelId: value.id,
                                                        city: value.city,
                                                        country: value.country,
                                                        date: value.date_start,
                                                        endDate: value.date_end,
                                                      ),
                                                    ))
                                                .then((value) =>
                                                    Navigator.of(context).pop())
                                          }
                                        else
                                          {
                                            showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                ),
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return WarningModal(
                                                    text:
                                                        "Impossible de rejoindre ce voyage",
                                                    url_animation:
                                                        'assets/lottieanimate/error.json',
                                                  );
                                                }),
                                          }
                                      });
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
