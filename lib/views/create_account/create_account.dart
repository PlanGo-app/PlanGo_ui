import 'package:flutter/material.dart';
import 'package:plango_front/views/components/rounded_button.dart';
import 'package:plango_front/views/create_account/create_account_background.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  String? pseudo;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return BackgroundCreateAccount(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Pseudo")),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            pseudo = value;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration:
                              const InputDecoration(label: Text("Email")),
                          validator: validateEmail,
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              label: Text("Mot de passe")),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      RoundedButton(
                        text: 'Créer',
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(pseudo);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}
