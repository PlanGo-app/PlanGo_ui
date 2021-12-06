import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/model/pin.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class PinService {
  Future<List<Pin>?> getPins(int travelId) async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "travel/$travelId/pins"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      if (response.statusCode == 200) {
        List<Pin> pins = [];
        for (dynamic pin
            in json.decode(utf8.decode(response.bodyBytes))["pins"]) {
          pins.add(Pin.fromJson(pin));
        }
        return pins;
      } else {
        return null;
      }
    });
  }

  Future<http.Response> CreatePin(
      String name, double longitude, double latitude, int travelId) async {
    return Storage.getToken().then((token) async {
      return await http
          .post(
        Uri.parse(HTTP + "pin"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'longitude': longitude.toString(),
          'latitude': latitude.toString(),
          'travelId': travelId.toString(),
        }),
      )
          .then((value) {
        return value;
      });
    });
  }

  Future<http.Response> DeletePin(
      double longitude, double latitude, int travelId) async {
    return Storage.getToken().then((token) async {
      return await http.delete(
        Uri.parse(HTTP +
            "pin/travel/$travelId?longitude=$longitude&latitude=$latitude"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ).then((value) {
        return value;
      });
    });
  }
}
