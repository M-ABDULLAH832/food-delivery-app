import '../models/food_model.dart';
import '../utils/app_images.dart';

final List<FoodModel> recommendedFoods = [
  FoodModel(
    name: "Double Burger",
    image: AppImages.burger2,
    price: 10.99,
    rating: 4.9,
    time: "18 min",
  ),

  FoodModel(
    name: "Cold Drink",
    image: AppImages.drink,
    price: 2.99,
    rating: 4.6,
    time: "5 min",
  ),

  FoodModel(
    name: "Dessert",
    image: AppImages.dessert,
    price: 6.99,
    rating: 4.8,
    time: "12 min",
  ),
];