import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account.dart';
import 'package:plango_front/views/sharing/sharing_page.dart';
import 'package:plango_front/views/travels_list/travels_list.dart';
import 'package:plango_front/views/welcome_page/welcome_page_bloc/welcome_page_bloc.dart';
import 'background_welcome_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WelcomePageBloc(),
        child: const Background(
          child: FormLogin(),
        ));
  }
}

// ignore: must_be_immutable
class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: const [
            Label(
                text: "Votre adresse mail :", color: kPrimaryLightColor),
            Login(),
          ],
        ),
        Stack(
          children: const [
            Label(
              text: "Votre mot de passe :",
              color: kPrimaryLightColor,
            ),
            Login(),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (
                      context,
                      ) =>
                      CreateAccount(),
                ));
          },
          child: Container(
            width: 200,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 5),
            child: const Label(
              text: "Créer un compte",
              color: kPrimaryLightColor,
            ),
          ),
        ),
        RoundedButton(
          text: "Connexion",
          press: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const TravelsList(),
            ));
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool selected = false;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomePageBloc, WelcomePageState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 240,
            child: const TextField(
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          );
        });
  }
}
