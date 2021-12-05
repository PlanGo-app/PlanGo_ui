import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

class CountryCityService {
  Future<LatLng> getLatLng(city, country) async {
    var result = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search.php?city=' +
            city +
            '&country=' +
            country +
            '&format=jsonv2'));
    var res = json.decode(result.body);
    return LatLng(double.parse(res[0]["lat"]), double.parse(res[0]["lon"]));
  }

  Future<List<Place>> search(text) {
    return Nominatim.searchByName(query: text, limit: 10
        // country: country,
        );
  }

  Future<Place> revserseSearch(double latitude, double longitude) {
    return Nominatim.reverseSearch(lat: latitude, lon: longitude, zoom: 18);
  }

  Future<dynamic> getParentInfo(parentId) async {
    var result = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/details?place_id=$parentId&format=json'));
    var res = json.decode(result.body);
    try {
      return res["names"]["name:en"];
    } catch (_) {
      return res["localname"];
    }
  }
}
