import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/util/constant.dart';

class AccountService {
  Future<http.Response> CreateUser(username, email, password) async {
    return await http.post(
      Uri.parse(HTTP + "/auth/signup"),
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );
  }
}
