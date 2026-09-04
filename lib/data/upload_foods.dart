import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_data.dart';

Future<void> uploadFoods() async {
  final firestore = FirebaseFirestore.instance;

  for (int i = 0; i < foodList.length; i++) {
    final food = foodList[i];

    await firestore.collection('foods').doc('food_${i + 1}').set({
      'name': food.name,
      'image': food.image,
      'price': food.price,
      'rating': food.rating,
      'time': food.time,
      'description': food.description,
      'calories': food.calories,
      'category': food.category,
    });
  }
}