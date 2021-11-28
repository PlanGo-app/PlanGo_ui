import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:plango_front/model/item_model.dart';

class PlanningEventService {
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
