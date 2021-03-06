import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/model/travel.dart';
import 'package:plango_front/model/user.dart';
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
        for (dynamic travel
            in json.decode(utf8.decode(response.bodyBytes))["travels"]) {
          travels.add(Travel.fromJson(travel));
        }
        return travels;
      } else {
        throw Exception("Failed to load travels");
      }
    });
  }

  Future<Travel?> joinTravel(code) async {
    return Storage.getToken().then((token) async {
      return await http.post(
        Uri.parse(HTTP + "travel/invitation?code=$code"),
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
      );
    }).then((response) {
      if (response.statusCode == 200) {
        return Travel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        return null;
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
        return Travel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        return null;
      }
    });
  }

  Future<http.Response> deleteTravel(travelId) async {
    return Storage.getToken().then((token) async {
      return await http.delete(
        Uri.parse(HTTP + "travel/$travelId/me"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    }).then((response) {
      return response;
    });
  }

  Future<http.Response> kickMember(userId, travelId) async {
    return Storage.getToken().then((token) async {
      return await http.delete(
        Uri.parse(HTTP + "travel/$travelId/member/$userId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    }).then((response) {
      return response;
    });
  }

  Future<List<User>> getMembers(int travelId) async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "travel/$travelId/members"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      if (response.statusCode == 200) {
        List<User> members = [];
        for (dynamic member
            in json.decode(utf8.decode(response.bodyBytes))["members"]) {
          members.add(User.fromJson(member));
        }
        return members;
      } else {
        throw Exception("Failed to get members");
      }
    });
  }
}
