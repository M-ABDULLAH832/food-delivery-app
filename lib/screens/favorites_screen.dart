import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/favorite_provider.dart';
import '../utils/app_colors.dart';
import 'food_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteProvider>().favoriteFoods;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Favorites",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              onPressed: () {
                _showClearDialog(context);
              },
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
              ),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? const _EmptyFavorites()
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              itemCount: favorites.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                return _FavoriteCard(
                  food: favorites[index],
                );
              },
            ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Clear Favorites?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to remove all favorite foods?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoriteProvider>().clearFavorites();

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Favorites cleared"),
                  ),
                );
              },
              child: const Text(
                "Clear",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final dynamic food;

  const _FavoriteCard({
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final cartProvider = context.read<CartProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FoodDetailsScreen(
              food: food,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
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
                        top: Radius.circular(22),
                      ),
                    ),
                    child: Image.asset(
                      food.image,
                      fit: BoxFit.contain,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.fastfood_rounded,
                          color: AppColors.primary,
                          size: 55,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        favoriteProvider.removeFavorite(food);
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: 20,
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 17,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          food.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          food.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Rs ${food.price.toStringAsFixed(0)}",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartProvider.addToCart(food);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${food.name} added to cart",
                                ),
                                duration:
                                    const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 22,
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

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 55,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              "No Favorites Yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Tap the heart icon on a food item\nto add it to your favorites.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}