import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/welcome_page/welcome_page_bloc.dart';
import 'background_welcome_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WelcomePageBloc(),
        child: Background(
          child: FormLogin(),
        ));
  }
}

// ignore: must_be_immutable
class FormLogin extends StatelessWidget {
  FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: [
            const Label(
                text: "Votre adresse mail :", color: kPrimaryLightColor),
            Login(),
          ],
        ),
        Stack(
          children: [
            const Label(
              text: "Votre mot de passe :",
              color: kPrimaryLightColor,
            ),
            Login(),
          ],
        ),
        RoundedButton(
          text: "Connexion",
          press: () {},
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

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
            child: TextField(
              onTap: () {
                  context.read<WelcomePageBloc>().add(const TypingEvent());
              },

              decoration: const InputDecoration(
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
