import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class AccountService {
  Future<http.Response> CreateUser(username, email, password) async {
    return await http.post(
      Uri.parse(HTTP + "auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'pseudo': username,
        'email': email,
        'password': password,
      }),
    );
  }

  Future<http.Response> GetUser() async {
    return Storage.getToken().then((token) async {
      if (token != null)
        return await http.get(
          Uri.parse(HTTP + "user"),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
        );
      return http.Response("", 400);
    });
  }

  Future<http.Response> Login(pseudo, password) async {
    return await http.post(
      Uri.parse(HTTP + "auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'pseudo': pseudo,
        'password': password,
      }),
    );
  }
}
