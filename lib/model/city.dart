import 'package:latlong2/latlong.dart';

class City {
  String name;
  LatLng latlng;

  City({
    required this.name,
    required this.latlng,
  });
  //
  // factory Country.fromJson(Map<String, dynamic> parsedJson) {
  //   return Country(
  //     name: parsedJson['translations']['fra']['common'].toString(),
  //     latlng: parsedJson['latlng'].toString(),
  //   );
  // }
}
