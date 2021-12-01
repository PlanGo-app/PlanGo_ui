import 'package:plango_front/model/travel.dart';

class Pin {
  String name;
  double latitude;
  double longitude;
  Travel travel; // maybe never used on the front

  Pin(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.travel});

  factory Pin.fromJson(Map<String, dynamic> parsedJson) {
    return Pin(
        name: parsedJson["name"],
        latitude: parsedJson["latitude"],
        longitude: parsedJson["longitude"],
        travel: Travel.fromJson(parsedJson["travel"]));
  }
}
