class FoodModel {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String time;

  final String description;
  final int calories;

  int quantity;

  FoodModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.time,
    required this.description,
    required this.calories,
    this.quantity = 1,
  });
}