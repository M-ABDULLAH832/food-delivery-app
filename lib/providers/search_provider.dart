import 'package:flutter/foundation.dart';

import '../models/food_model.dart';

class SearchProvider extends ChangeNotifier {
  final List<FoodModel> _allFoods;

  SearchProvider(this._allFoods);

  String _query = '';
  String _selectedCategory = 'All';

  final List<String> _recentSearches = [];

  String get query => _query;

  String get selectedCategory => _selectedCategory;

  List<String> get recentSearches => List.unmodifiable(_recentSearches);

  List<String> get categories {
    final categorySet = <String>{'All'};

    for (final food in _allFoods) {
      categorySet.add(food.category);
    }

    return categorySet.toList();
  }

  List<FoodModel> get filteredFoods {
    final searchQuery = _query.trim().toLowerCase();

    return _allFoods.where((food) {
      final matchesSearch = searchQuery.isEmpty ||
          food.name.toLowerCase().contains(searchQuery) ||
          food.description.toLowerCase().contains(searchQuery);

      final matchesCategory = _selectedCategory == 'All' ||
          food.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  bool get hasResults => filteredFoods.isNotEmpty;

  bool get isFiltering =>
      _query.trim().isNotEmpty || _selectedCategory != 'All';

  void search(String value) {
    _query = value;
    notifyListeners();
  }

  void submitSearch() {
    final searchValue = _query.trim();

    if (searchValue.isEmpty) {
      return;
    }

    _addToRecentSearches(searchValue);
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