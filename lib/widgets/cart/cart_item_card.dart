import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food_model.dart';
import '../../providers/cart_provider.dart';
import '../../utils/app_colors.dart';

class CartItemCard extends StatelessWidget {
  final FoodModel food;

  const CartItemCard({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              food.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

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

                const SizedBox(height: 6),

                Text(
                  "Rs ${food.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        cartProvider.decreaseQuantity(food);
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),

                    Text(
                      food.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        cartProvider.increaseQuantity(food);
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              cartProvider.removeFromCart(food);
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}