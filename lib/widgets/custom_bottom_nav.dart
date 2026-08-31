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
          icon: Icon(
            Icons.home_rounded,
          ),
          label: "Home",
        ),

        const BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_rounded,
          ),
          label: "Favorites",
        ),

        BottomNavigationBarItem(
          icon: Consumer<CartProvider>(
            builder: (
              context,
              cartProvider,
              child,
            ) {
              final count =
                  cartProvider.totalItems;

              return Badge(
                isLabelVisible: count > 0,
                label: Text(
                  "$count",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.shopping_cart_rounded,
                ),
              );
            },
          ),
          label: "Cart",
        ),

        const BottomNavigationBarItem(
          icon: Icon(
            Icons.receipt_long_rounded,
          ),
          label: "Orders",
        ),

        const BottomNavigationBarItem(
          icon: Icon(
            Icons.person_rounded,
          ),
          label: "Profile",
        ),
      ],
    );
  }
}