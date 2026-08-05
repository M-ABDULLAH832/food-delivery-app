import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({super.key});

  Widget ingredientChip(
    String emoji,
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 22),
          ),

          const SizedBox(width: 8),

          Text(
            title,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 18),

          Wrap(
            children: [
              ingredientChip("🍗", "Chicken"),
              ingredientChip("🧀", "Cheese"),
              ingredientChip("🥬", "Lettuce"),
              ingredientChip("🍅", "Tomato"),
              ingredientChip("🥖", "Bun"),
            ],
          ),
        ],
      ),
    );
  }
}