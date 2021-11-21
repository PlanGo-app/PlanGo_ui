class Country {
  String name;
  String latlng;

  Country({required this.name, required this.latlng});

  factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
        name: parsedJson['name']['common'].toString(),
        latlng: parsedJson['latlng'].toString());
  }
}
