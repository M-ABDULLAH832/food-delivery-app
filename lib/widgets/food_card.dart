import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food_model.dart';
import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';
import '../screens/food_details_screen.dart';
import '../utils/app_colors.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<FavoriteProvider>().isFavorite(food);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetailsScreen(food: food),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: const EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffFFF4EC),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        food.image,
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                        errorBuilder: (context,error, stackTrace) {
                          return const Icon(
                            Icons.fastfood_rounded,
                            size: 70,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<FavoriteProvider>()
                            .toggleFavorite(food);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: isFavorite
                              ? Colors.red
                              : Colors.grey.shade700,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          food.rating.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          food.time,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Rs ${food.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CartProvider>()
                                .addToCart(food);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("${food.name} added to cart"),
                                duration:
                                    const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}