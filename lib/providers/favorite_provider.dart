import 'package:flutter/foundation.dart';

import '../models/food_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<FoodModel> _favoriteItems = [];

  List<FoodModel> get favoriteItems =>
      List.unmodifiable(_favoriteItems);

  List<FoodModel> get favoriteFoods =>
      List.unmodifiable(_favoriteItems);

  int get favoriteCount => _favoriteItems.length;

  bool isFavorite(FoodModel food) {
    return _favoriteItems.any(
      (item) => item.name == food.name,
    );
  }

  void toggleFavorite(FoodModel food) {
    final index = _favoriteItems.indexWhere(
      (item) => item.name == food.name,
    );

    if (index != -1) {
      _favoriteItems.removeAt(index);
    } else {
      _favoriteItems.add(food);
    }

    notifyListeners();
  }

  void removeFavorite(FoodModel food) {
    _favoriteItems.removeWhere(
      (item) => item.name == food.name,
    );

    notifyListeners();
  }

  void clearFavorites() {
    if (_favoriteItems.isEmpty) {
      return;
    }

    _favoriteItems.clear();
    notifyListeners();
  }
}