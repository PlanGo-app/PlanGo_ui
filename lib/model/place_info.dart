import 'package:latlong2/latlong.dart';

class PlaceInfo {
  String name;
  String street;
  String city;
  String price;
  String openingHours;
  String website;
  LatLng point;

  PlaceInfo({
    required this.name,
    required this.street,
    required this.city,
    required this.price,
    required this.openingHours,
    required this.website,
    required this.point,
  });

  factory PlaceInfo.fromJson(dynamic parsedJson) {
    // print(parsedJson);
    String name = parsedJson['localname'];
    String? street;
    String? city;
    String? price;
    String? openingHours;
    String? website;
    LatLng point = LatLng(parsedJson["geometry"]["coordinates"][1],
        parsedJson["geometry"]["coordinates"][0]);

    try {
      street = [
        (parsedJson["addresstags"]["housenumber"] ?? ""),
        (parsedJson["addresstags"]["street"] ?? "")
      ].where((i) => (i.length > 0)).join(", ");
      city = [
        (parsedJson["calculated_postcode"] ?? ""),
        (parsedJson["addresstags"]["city"] ?? "")
      ].where((i) => (i.length > 0)).join(", ");
    } catch (e) {}
    try {
      price = parsedJson["extratags"]["fee"] ?? "";
      openingHours = parsedJson["extratags"]["opening_hours"] ?? "";
      website = parsedJson["extratags"]["website"] ?? "";
    } catch (e) {}

    return PlaceInfo(
        name: name,
        street: street ?? "",
        city: city ?? "",
        price: price ?? "",
        openingHours: openingHours ?? "",
        website: website ?? "",
        point: point);
  }
}
