import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = 'kplango';

  static Future setToken(dynamic token) async => await _storage.write(
      key: _keyToken, value: json.decode(token.body)["token"]);

  static Future<String?> getToken() async =>
      await _storage.read(key: _keyToken);
}
