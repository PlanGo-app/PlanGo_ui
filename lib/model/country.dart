class Country {
  String name;
  String latlng;
  String code;
  String add_flag;
  String realName;

  Country({
    required this.name,
    required this.latlng,
    required this.code,
    required this.add_flag,
    required this.realName,
  });

  factory Country.fromJson(Map<String, dynamic> parsedJson) {
    return Country(
        name: parsedJson['translations']['fra']['common'].toString(),
        latlng: parsedJson['latlng'].toString(),
        code: parsedJson['cca2'].toString(),
        add_flag: parsedJson['flags']['svg'].toString(),
        realName: parsedJson['name']['common'].toString());
  }
}
