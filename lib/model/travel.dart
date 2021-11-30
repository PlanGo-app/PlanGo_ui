class Travel {
  int id;
  String name;
  String country;
  String city;
  DateTime date_start;
  DateTime date_end;
  String invitationCode;

  Travel(
      {required this.id,
      required this.name,
      required this.country,
      required this.city,
      required this.date_start,
      required this.date_end,
      required this.invitationCode});

  factory Travel.fromJson(Map<String, dynamic> parsedJson) {
    return Travel(
        id: parsedJson["id"],
        name: parsedJson['name'],
        country: parsedJson['country'],
        city: parsedJson['city'],
        date_start: DateTime.parse(parsedJson['dateStart'].toString()),
        date_end: DateTime.parse(parsedJson['dateEnd'].toString()),
        invitationCode: parsedJson['invitationCode']);
  }
}
