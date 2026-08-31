import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/food_card.dart';
import '../widgets/category_list.dart';

class AllFoodsScreen extends StatelessWidget {
  const AllFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    final foods = searchProvider.filteredFoods;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "All Foods",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 5, 22, 16),
            child: Text(
              "Choose your favorite food",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 22),
            child: CategoryList(),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: foods.isEmpty
                ? const _EmptyFoods()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      0,
                      22,
                      25,
                    ),
                    physics:
                        const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        food: foods[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFoods extends StatelessWidget {
  const _EmptyFoods();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(
                  alpha: 0.10,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fastfood_outlined,
                size: 45,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              "No foods found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Try selecting another category.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}