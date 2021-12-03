class Pin {
  String name;
  double latitude;
  double longitude;
  int travel;

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
        travel: parsedJson["travel"]);
  }
}
