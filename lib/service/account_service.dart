import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/util/constant.dart';

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
