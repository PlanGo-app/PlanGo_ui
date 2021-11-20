import 'package:flutter/material.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/map_page/map_page.dart';

class CreateTravel extends StatelessWidget {
  const CreateTravel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      press: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (
                context,
              ) =>
                  const MapPage(),
            ));
      },
      text: "Créer",
    );
  }
}
