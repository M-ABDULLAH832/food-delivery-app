import '../models/food_model.dart';

final List<FoodModel> foodList = [
  FoodModel(
    name: "Cheese Burger",
    image: "assets/images/burger.png",
    price: 899.0,
    rating: 4.8,
    time: "15 min",
    description:
        "Juicy grilled chicken burger with fresh lettuce, cheddar cheese and our special signature sauce.",
    calories: 520,
    category: "Burgers",
  ),

  FoodModel(
    name: "Pepper Pizza",
    image: "assets/images/pizza.png",
    price: 1250.0,
    rating: 4.9,
    time: "20 min",
    description:
        "Freshly baked pepper pizza loaded with mozzarella cheese, tomato sauce and delicious toppings.",
    calories: 690,
    category: "Pizza",
  ),

  FoodModel(
    name: "French Fries",
    image: "assets/images/fries.png",
    price: 549.0,
    rating: 4.7,
    time: "10 min",
    description:
        "Golden crispy French fries made from premium potatoes, lightly seasoned with sea salt and served with tomato ketchup.",
    calories: 380,
    category: "Snacks",
  ),
];