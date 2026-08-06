import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          elevation: 10,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: "Favorites",
            ),

            BottomNavigationBarItem(
              label: "Cart",
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart_rounded),

                  if (cartProvider.cartItems.isNotEmpty)
                    Positioned(
                      right: -8,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cartProvider.cartItems.length.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}