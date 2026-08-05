import '../models/food_model.dart';
import '../utils/app_images.dart';

final List<FoodModel> recommendedFoods = [
  FoodModel(
    name: "Double Burger",
    image: AppImages.burger2,
    price: 1099.0,
    rating: 4.9,
    time: "18 min",
    description:
        "Double juicy chicken patties with melted cheddar cheese, fresh lettuce, tomatoes and our signature burger sauce.",
    calories: 720,
  ),

  FoodModel(
    name: "Cold Drink",
    image: AppImages.drink,
    price: 299.0,
    rating: 4.6,
    time: "5 min",
    description:
        "Refreshing chilled soft drink served with ice. Perfect to enjoy with burgers, pizza and fries.",
    calories: 180,
  ),

  FoodModel(
    name: "Dessert",
    image: AppImages.dessert,
    price: 699.0,
    rating: 4.8,
    time: "12 min",
    description:
        "Delicious chocolate dessert topped with cream and colorful sprinkles. Sweet, soft and freshly prepared.",
    calories: 450,
  ),
];