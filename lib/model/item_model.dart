enum AnimalType { land, air }

class Marker {
  final String name;

  Marker({
    required this.name,
  });
  factory Marker.fromJson(Map<String, dynamic> parsedJson) {
    return Marker(name: parsedJson['name']);
  }
}
//
// final allMarkers = [
//   Marker(
//     name: 'assets/image/plango_logo.png',
//   ),
//   Marker(
//     name: 'assets/image/plango_title.png',
//   ),
// ];
