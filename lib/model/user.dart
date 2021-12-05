class User {
  String pseudo;
  String id;
  String role;

  User({
    required this.pseudo,
    required this.id,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        pseudo: parsedJson['user']['pseudo'].toString(),
        id: parsedJson['user']['id'].toString(),
        role: parsedJson['role'].toString());
  }
}
