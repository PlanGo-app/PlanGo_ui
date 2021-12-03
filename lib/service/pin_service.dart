import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/model/pin.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class PinService {
  Future<List<Pin>> getPins(int id) async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "travel/$id/pins"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      if (response.statusCode == 200) {
        List<Pin> pins = [];
        for (dynamic pin in json.decode(response.body)["travels"]) {
          pins.add(Pin.fromJson(pin));
        }
        return pins;
      } else {
        throw Exception("Failed to load Pin");
      }
    });
  }

  Future<http.Response> CreatePin(
      String name, double longitude, double latitude, int travelId) async {
    return await http.post(
      Uri.parse(HTTP + "pin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'name': name,
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
        'travelId': travelId.toString(),
      }),
    );
  }
}
