import 'package:flutter/foundation.dart';

import '../models/food_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<FoodModel> _favoriteItems = [];

  List<FoodModel> get favoriteItems => _favoriteItems;

  // Used by FavoritesScreen
  List<FoodModel> get favoriteFoods => _favoriteItems;

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
    _favoriteItems.clear();
    notifyListeners();
  }

  int get favoriteCount {
    return _favoriteItems.length;
  }
}