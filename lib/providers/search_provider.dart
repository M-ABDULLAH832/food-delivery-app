import 'package:flutter/foundation.dart';

import '../models/food_model.dart';

class SearchProvider extends ChangeNotifier {
  List<FoodModel> _allFoods;

  SearchProvider(this._allFoods);

  String _query = '';
  String _selectedCategory = 'All';

  final List<String> _recentSearches = [];

  String get query => _query;

  String get selectedCategory => _selectedCategory;

  List<String> get recentSearches =>
      List.unmodifiable(_recentSearches);

  List<String> get categories {
    final categories = <String>['All'];

    for (final food in _allFoods) {
      if (!categories.contains(food.category)) {
        categories.add(food.category);
      }
    }

    return categories;
  }

  List<FoodModel> get filteredFoods {
    final searchQuery = _query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      if (_selectedCategory == 'All') {
        return List<FoodModel>.from(_allFoods);
      }

      return _allFoods
          .where((food) => food.category == _selectedCategory)
          .toList();
    }

    return _allFoods.where((food) {
      final name = food.name.toLowerCase();
      final description = food.description.toLowerCase();
      final category = food.category.toLowerCase();

      final matchesSearch =
          name.contains(searchQuery) ||
          description.contains(searchQuery) ||
          category.contains(searchQuery);

      final matchesCategory =
          _selectedCategory == 'All' ||
          food.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool get hasResults => filteredFoods.isNotEmpty;

  bool get isFiltering =>
      _query.trim().isNotEmpty || _selectedCategory != 'All';

  void updateFoods(List<FoodModel> foods) {
    _allFoods = foods;
    notifyListeners();
  }

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  void submitSearch() {
    final value = _query.trim();

    if (value.isEmpty) {
      return;
    }

    _addToRecentSearches(value);
    notifyListeners();
  }

  void selectRecentSearch(String value) {
    _query = value;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearCategory() {
    _selectedCategory = 'All';
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    notifyListeners();
  }

  void clearFilters() {
    _query = '';
    _selectedCategory = 'All';
    notifyListeners();
  }

  void removeRecentSearch(String value) {
    _recentSearches.remove(value);
    notifyListeners();
  }

  void clearRecentSearches() {
    _recentSearches.clear();
    notifyListeners();
  }

  void _addToRecentSearches(String value) {
    final searchValue = value.trim();

    if (searchValue.isEmpty) {
      return;
    }

    _recentSearches.removeWhere(
      (item) => item.toLowerCase() == searchValue.toLowerCase(),
    );

    _recentSearches.insert(0, searchValue);

    if (_recentSearches.length > 5) {
      _recentSearches.removeLast();
    }
  }
}