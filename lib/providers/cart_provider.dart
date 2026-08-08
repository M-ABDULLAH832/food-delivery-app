import 'package:flutter/material.dart';

import '../models/food_model.dart';

class CartProvider extends ChangeNotifier {
  final List<FoodModel> _cartItems = [];

  List<FoodModel> get cartItems => _cartItems;

  void addToCart(FoodModel food) {
    final index = _cartItems.indexWhere(
      (item) => item.name == food.name,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(
        FoodModel(
          name: food.name,
          image: food.image,
          price: food.price,
          rating: food.rating,
          time: food.time,
          description: food.description,
          calories: food.calories,
          category: food.category,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeFromCart(FoodModel food) {
    _cartItems.removeWhere(
      (item) => item.name == food.name,
    );

    notifyListeners();
  }

  void increaseQuantity(FoodModel food) {
    food.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(FoodModel food) {
    if (food.quantity > 1) {
      food.quantity--;
    } else {
      removeFromCart(food);
      return;
    }

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (final item in _cartItems) {
      total += item.price * item.quantity;
    }

    return total;
  }

  int get totalItems {
    int total = 0;

    for (final item in _cartItems) {
      total += item.quantity;
    }

    return total;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}