import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/model/travel.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class TravelService {
  Future<List<Travel>> getTravels() async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "user/travels"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      if (response.statusCode == 200) {
        List<Travel> travels = [];
        for (dynamic travel in json.decode(response.body)["travels"]) {
          travels.add(Travel.fromJson(travel));
        }
        return travels;
      } else {
        throw Exception("Failed to load travels");
      }
    });
  }

  Future<Travel> joinTravel(code) async {
    return Storage.getToken().then((token) async {
      return await http.post(
        Uri.parse(HTTP + "travel/invitation?code=$code"),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      );
    }).then((response) {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return Travel.fromJson(json.decode(response.body));
      } else {
        throw Exception("Failed to join travels");
      }
    });
  }

  Future<Travel?> addTravel(
      String country, String city, DateTime dateStart, DateTime dateEnd) async {
    return Storage.getToken().then((token) async {
      return await http.post(
        Uri.parse(HTTP + "travel"),
        body: jsonEncode(<String, dynamic>{
          'country': country,
          'city': city,
          'dateStart': dateStart.toIso8601String(),
          'dateEnd': dateEnd.toIso8601String(),
        }),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      );
    }).then((response) {
      if (response.statusCode == 201) {
        return Travel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    });
  }
}
