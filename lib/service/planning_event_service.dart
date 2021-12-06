import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plango_front/model/planning_event.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class PlanningEventService {
  Future<List<PlanningEvent>> getPlanningEvents(int travelId) async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "travel/$travelId/planningEvents"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      if (response.statusCode == 200) {
        List<PlanningEvent> planningEvents = [];
        for (dynamic planningEvent
            in json.decode(utf8.decode(response.bodyBytes))["planningEvents"]) {
          planningEvents.add(PlanningEvent.fromJson(planningEvent));
        }
        return planningEvents;
      } else {
        throw Exception("Failed to load planningEvent");
      }
    });
  }

  Future<http.Response> updatePlanningEvent(
      int id, String name, DateTime dateStart, DateTime dateEnd) async {
    return Storage.getToken().then((token) async {
      return await http.put(Uri.parse(HTTP + "planning_event"),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, String>{
            'id': id.toString(),
            'name': name,
            "dateStart": dateStart.toIso8601String(),
            "dateEnd": dateEnd.toIso8601String(),
          }));
    }).then((response) {
      print(response.statusCode);
      print(response.body);
      return response;
    });
  }

  Future<http.Response> deletePlanningEvent(
    int pinId,
  ) async {
    return Storage.getToken().then((token) async {
      return await http.delete(
        Uri.parse(HTTP + "pin/$pinId"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    }).then((response) {
      print(response.statusCode);
      print(response.body);
      return response;
    });
  }
}
