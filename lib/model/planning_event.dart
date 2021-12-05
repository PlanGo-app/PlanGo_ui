class PlanningEvent {
  int id;
  String name;
  DateTime? date_start;
  DateTime? date_end;
  int pinId;

  PlanningEvent(
      {required this.id,
      required this.name,
      required this.date_start,
      required this.date_end,
      required this.pinId});

  factory PlanningEvent.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return PlanningEvent(
        id: parsedJson["id"],
        name: parsedJson["name"],
        date_start: parsedJson["dateStart"] == null
            ? null
            : DateTime.parse(parsedJson["dateStart"].toString()),
        date_end: parsedJson["dateEnd"] == null
            ? null
            : DateTime.parse(parsedJson["dateEnd"].toString()),
        pinId: parsedJson["pinId"]);
  }
}
