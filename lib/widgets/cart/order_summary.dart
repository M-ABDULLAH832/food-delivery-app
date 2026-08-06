import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../utils/app_colors.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final subtotal = cartProvider.totalPrice;
        const deliveryFee = 150.0;
        final total = subtotal + deliveryFee;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildRow(
                title: "Subtotal",
                value: "Rs ${subtotal.toStringAsFixed(0)}",
              ),

              const SizedBox(height: 10),

              _buildRow(
                title: "Delivery Fee",
                value: "Rs ${deliveryFee.toStringAsFixed(0)}",
              ),

              const Divider(height: 30),

              _buildRow(
                title: "Total",
                value: "Rs ${total.toStringAsFixed(0)}",
                isTotal: true,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Checkout feature coming in Version 0.4",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Proceed to Checkout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppColors.primary : Colors.black,
          ),
        ),
      ],
    );
  }
}