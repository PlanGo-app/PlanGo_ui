import 'package:plango_front/model/travel.dart';

class Pin {
  String name;
  double latitiude;
  double longitude;
  Travel travel;

  Pin(
      {required this.name,
      required this.latitiude,
      required this.longitude,
      required this.travel});

  factory Pin.fromJson(Map<String, dynamic> parsedJson) {
    return Pin(
        name: parsedJson["name"],
        latitiude: parsedJson["latitude"],
        longitude: parsedJson["longitude"],
        travel: Travel.fromJson(parsedJson["travel"]));
  }
}
