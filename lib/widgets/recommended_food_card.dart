import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../utils/app_colors.dart';

class RecommendedFoodCard extends StatelessWidget {
  final FoodModel food;

  const RecommendedFoodCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: const Color(0xffFFF4EC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                food.image,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),

                    const SizedBox(width: 4),

                    Text(food.rating.toString()),

                    const SizedBox(width: 14),

                    const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 18,
                    ),

                    const SizedBox(width: 4),

                    Text(food.time),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Text(
                      "\$${food.price}",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}