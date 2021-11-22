class PlaceInfo {
  String name;
  String street;
  String city;

  PlaceInfo({required this.name, required this.street, required this.city});

  factory PlaceInfo.fromJson(dynamic parsedJson) {
    print(parsedJson);
    String name = parsedJson['localname'];
    String street;
    String city;
    try {
      street = [
        (parsedJson["addresstags"]["housenumber"] ?? ""),
        (parsedJson["addresstags"]["street"] ?? "")
      ].where((i) => (i.length > 0)).join(", ");
      city = [
        (parsedJson["calculated_postcode"] ?? ""),
        (parsedJson["addresstags"]["city"] ?? "")
      ].join(", ");
    } catch (e) {
      street = "";
      city = "";
    }

    return PlaceInfo(
      name: name,
      street: street,
      city: city,
    );
  }
}
