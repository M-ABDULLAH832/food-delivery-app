import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_model.dart';

class FoodRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<FoodModel>> watchFoods() {
    return _firestore.collection('foods').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return FoodModel(
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: (data['price'] as num?)?.toDouble() ?? 0,
          rating: (data['rating'] as num?)?.toDouble() ?? 0,
          time: data['time'] ?? '',
          description: data['description'] ?? '',
          calories: (data['calories'] as num?)?.toInt() ?? 0,
          category: data['category'] ?? '',
        );
      }).toList();
    });
  }
}