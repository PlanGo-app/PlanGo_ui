import 'dart:io' show Platform, exit;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plango_front/service/account_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/loading.dart';
import 'package:plango_front/util/storage.dart';
import 'package:plango_front/views/components/label.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/components/warning_animation.dart';
import 'package:plango_front/views/create_account/create_account.dart';
import 'package:plango_front/views/travels_list/travels_list.dart';
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
class FormLogin extends StatefulWidget {
  FormLogin({
    Key? key,
  }) : super(key: key);
  bool _loading = false;
  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccountService().GetUser().then((value) => {
          if (value.statusCode == 200)
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (
                    context,
                  ) =>
                          TravelsList()))
            }
        });

    return widget._loading
        ? const Loading()
        : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    const Label(
                        text: "Votre adresse mail :",
                        color: kPrimaryLightColor),
                    Login(
                      hide: false,
                      controller: pseudoController,
                    ),
                  ],
                ),
                Stack(
                  children: [
                    const Label(
                      text: "Votre mot de passe :",
                      color: kPrimaryLightColor,
                    ),
                    Login(
                      hide: true,
                      controller: passwordController,
                    ),
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
                    setState(() {
                      widget._loading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      AccountService()
                          .Login(pseudoController.text, passwordController.text)
                          .then((value) {
                        setState(() {
                          widget._loading = false;
                        });
                        switch (value.statusCode) {
                          case 200:
                            Storage.setToken(value);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TravelsList(),
                                )).then((value) {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else {
                                exit(0);
                              }
                            });
                            break;
                          default:
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return WarningModal(
                                    text: "Login ou mot de passe inexistant",
                                    url_animation:
                                        'assets/lottieanimate/error.json',
                                  );
                                });
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          );
  }
}

// ignore: must_be_immutable
class Login extends StatefulWidget {
  TextEditingController? controller;
  bool hide;
  Login({Key? key, required this.controller, required this.hide})
      : super(key: key);

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
              obscureText: widget.hide,
              enableSuggestions: !widget.hide,
              autocorrect: !widget.hide,
              controller: widget.controller,
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
