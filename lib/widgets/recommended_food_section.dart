import 'package:flutter/material.dart';

import '../data/recommended_food_data.dart';
import 'food_card.dart';

class RecommendedFoodSection extends StatelessWidget {
  const RecommendedFoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recommended For You",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedFoodList.length,
            itemBuilder: (context, index) {
              return FoodCard(
                food: recommendedFoodList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}