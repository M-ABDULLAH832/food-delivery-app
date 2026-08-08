class FoodModel {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String time;
  final String description;
  final int calories;
  final String category;

  int quantity;

  FoodModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.time,
    required this.description,
    required this.calories,
    required this.category,
    this.quantity = 0,
  });
}