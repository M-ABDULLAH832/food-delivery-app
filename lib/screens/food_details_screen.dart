import 'package:flutter/material.dart';

import '../models/food_model.dart';
import '../utils/app_colors.dart';
import '../widgets/details/details_header.dart';
import '../widgets/details/food_info_card.dart';
import '../widgets/details/ingredients_section.dart';
import '../widgets/details/add_to_cart_button.dart';
import '../widgets/quantity_selector.dart';

class FoodDetailsScreen extends StatelessWidget {
  final FoodModel food;

  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              DetailsHeader(food: food),

              const SizedBox(height: 25),

              FoodInfoCard(food: food),

              const SizedBox(height: 30),

              const IngredientsSection(),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const QuantitySelector(),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              AddToCartButton(
                price: food.price,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${food.name} added to cart",
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}