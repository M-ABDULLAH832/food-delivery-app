import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/cart/cart_item_card.dart';
import '../widgets/cart/empty_cart.dart';
import '../widgets/cart/order_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.background,
            centerTitle: true,
            title: const Text(
              "My Cart",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),

          body: cartProvider.cartItems.isEmpty
              ? const EmptyCart()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          return CartItemCard(
                            food: cartProvider.cartItems[index],
                          );
                        },
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: OrderSummary(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}