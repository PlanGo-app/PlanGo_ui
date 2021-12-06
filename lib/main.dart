import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plango_front/service/account_service.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/views/travels_list/travels_list.dart';
import 'package:plango_front/views/welcome_page/welcome_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plango',
      home: Scaffold(
        body: SplashScreenWidget(),
      ),
    );
  }
}

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        navigateAfterFuture: loadFromFuture(),
        title: const Text(
          'Bienvenue Dans Plango',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: kPrimaryColor),
        ),
        image: Image.asset("assets/image/plango_logo.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: const TextStyle(),
        photoSize: 100.0,
        loadingText: const Text("Loading ..."),
        loaderColor: Colors.red);
  }

  Future<Widget> loadFromFuture() async {
    return AccountService().GetUser().then((value) {
      if (value.statusCode == 200) {
        USER_NAME = json.decode(value.body)["pseudo"];
        return Scaffold(body: TravelsList());
      }
      return const Scaffold(body: WelcomePage());
    });
  }
}
