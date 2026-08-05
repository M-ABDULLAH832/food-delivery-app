import 'package:flutter/material.dart';

import '../../models/food_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class FoodInfoCard extends StatelessWidget {
  final FoodModel food;

  const FoodInfoCard({
    super.key,
    required this.food,
  });

  Widget buildInfoBox({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            food.name,
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 12),

          Text(
            "Rs. ${food.price.toStringAsFixed(0)}",
            style: AppTextStyles.price,
          ),

          const SizedBox(height: 25),

          Row(
            children: [

              buildInfoBox(
                icon: Icons.star,
                title: "${food.rating}",
                color: AppColors.star,
              ),

              const SizedBox(width: 12),

              buildInfoBox(
                icon: Icons.local_fire_department,
                title: "${food.calories} kcal",
                color: Colors.red,
              ),

              const SizedBox(width: 12),

              buildInfoBox(
                icon: Icons.access_time,
                title: food.time,
                color: AppColors.primary,
              ),
            ],
          ),

          const SizedBox(height: 28),

          Text(
            "Description",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 10),

          Text(
            food.description,
            style: AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}