import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account.dart';
import 'package:plango_front/views/welcome_page/welcome_page_bloc/welcome_page_bloc.dart';

import 'background_welcome_page.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

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
  final _formKey = GlobalKey<FormState>();

  FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: const [
              Label(text: "Votre adresse mail :", color: kPrimaryLightColor),
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
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // print(_formKey.currentState!.widget.child.toString());
              }
              // AccountService().Login(pseudo, password)
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => TravelsList(),
              //     ));
            },
          ),
        ],
      ),
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
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                // widget.email = value;
              },
            ),
          );
        });
  }
}
