enum AnimalType { land, air }

class Animal {
  final String imageUrl;
  final AnimalType type;

  Animal({
    required this.imageUrl,
    required this.type,
  });
}

final allAnimals = [
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/image/plango_logo.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/image/plango_title.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/image/plango_logo.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/image/plango_logo.png',
  ),
  Animal(
    type: AnimalType.air,
    imageUrl: 'assets/image/plango_logo.png',
  ),
  Animal(
    type: AnimalType.land,
    imageUrl: 'assets/image/plango_logo.png',
  ),
];
