import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"icon": Icons.lunch_dining, "title": "Burger"},
      {"icon": Icons.local_pizza, "title": "Pizza"},
      {"icon": Icons.emoji_food_beverage, "title": "Drinks"},
      {"icon": Icons.icecream, "title": "Dessert"},
      {"icon": Icons.fastfood, "title": "Snacks"},
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? AppColors.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    categories[index]["icon"] as IconData,
                    color: index == 0
                        ? Colors.white
                        : AppColors.primary,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  categories[index]["title"] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}