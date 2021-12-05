import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:plango_front/model/item_model.dart';
import 'package:plango_front/model/planning_event.dart';
import 'package:plango_front/util/constant.dart';
import 'package:plango_front/util/storage.dart';

class PlanningEventService {
  Future<List<PlanningEvent>> getPins(int travelId) async {
    return Storage.getToken().then((token) async {
      return await http.get(
        Uri.parse(HTTP + "travel/$travelId/planningEvents"),
        headers: {'Authorization': 'Bearer $token'},
      );
    }).then((response) {
      print("get pin ${response.statusCode}");
      print("get pin ${response.body}");
      if (response.statusCode == 200) {
        List<PlanningEvent> planningEvents = [];
        for (dynamic planningEvent
            in json.decode(response.body)["planningEvents"]) {
          planningEvents.add(PlanningEvent.fromJson(planningEvent));
        }
        return planningEvents;
      } else {
        throw Exception("Failed to load planningEvent");
      }
    });
  }

  Future<List<Marker>> loadMarkers() async {
    await Future.delayed(const Duration(seconds: 1), () => {});
    String jsonString = await _loadMarkersAssets();
    final jsonResponse = json.decode(jsonString);
    List<Marker> travels = [];
    for (dynamic travel in jsonResponse) {
      travels.add(Marker.fromJson(travel));
    }
    return travels;
  }

  Future<String> _loadMarkersAssets() async {
    return await rootBundle
        .loadString('assets/marker.json'); // return your response
  }
}
