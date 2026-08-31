import 'package:flutter/material.dart';

import '../data/food_data.dart';
import 'food_card.dart';

class RecommendedFoodSection extends StatelessWidget {
  const RecommendedFoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendedFoods = foodList
        .where((food) => food.rating >= 4.8)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended For You",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedFoods.length,
            itemBuilder: (context, index) {
              return FoodCard(
                food: recommendedFoods[index],
              );
            },
          ),
        ),
      ],
    );
  }
}