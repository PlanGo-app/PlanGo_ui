class Travel {
  String name;
  String country;
  String city;
  DateTime date_start;
  DateTime date_end;

  Travel(
      {required this.name,
      required this.country,
      required this.city,
      required this.date_start,
      required this.date_end});

  factory Travel.fromJson(Map<String, dynamic> parsedJson) {
    return Travel(
        name: parsedJson['name'],
        country: parsedJson['country'],
        city: parsedJson['city'],
        date_start: DateTime.parse(parsedJson['date_start'].toString()),
        date_end: DateTime.parse(parsedJson['date_end'].toString()));
  }
}
