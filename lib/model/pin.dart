class Pin {
  String name;
  double latitude;
  double longitude;
  int travelId;

  Pin(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.travelId});

  factory Pin.fromJson(Map<String, dynamic> parsedJson) {
    return Pin(
        name: parsedJson["name"],
        latitude: parsedJson["latitude"],
        longitude: parsedJson["longitude"],
        travelId: parsedJson["travelId"]);
  }
}
