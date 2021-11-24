class Country {
  String name;
  String latlng;
  String code;
  String add_flag;

  Country(
      {required this.name,
      required this.latlng,
      required this.code,
      required this.add_flag});

  factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
        name: parsedJson['translations']['fra']['common'].toString(),
        latlng: parsedJson['latlng'].toString(),
        code: parsedJson['cca2'].toString(),
        add_flag: parsedJson['flags']['svg'].toString());
  }
}
