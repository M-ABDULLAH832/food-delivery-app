import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../utils/app_colors.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController =
      TextEditingController();

  String selectedPayment = "Cash on Delivery";

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    const double deliveryFee = 100;

    final subtotal = cartProvider.totalPrice;
    final total = subtotal + deliveryFee;

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
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          22,
          10,
          22,
          30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                controller: addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Enter your delivery address",
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(18),
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _PaymentOption(
              title: "Cash on Delivery",
              icon: Icons.payments_outlined,
              value: "Cash on Delivery",
              selectedValue: selectedPayment,
              onTap: () {
                setState(() {
                  selectedPayment = "Cash on Delivery";
                });
              },
            ),

            _PaymentOption(
              title: "Card Payment",
              icon: Icons.credit_card_outlined,
              value: "Card Payment",
              selectedValue: selectedPayment,
              onTap: () {
                setState(() {
                  selectedPayment = "Card Payment";
                });
              },
            ),

            const SizedBox(height: 28),

            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _SummaryRow(
                    title: "Items",
                    value: "${cartProvider.totalItems}",
                  ),

                  const SizedBox(height: 12),

                  _SummaryRow(
                    title: "Subtotal",
                    value:
                        "Rs ${subtotal.toStringAsFixed(0)}",
                  ),

                  const SizedBox(height: 12),

                  _SummaryRow(
                    title: "Delivery Fee",
                    value:
                        "Rs ${deliveryFee.toStringAsFixed(0)}",
                  ),

                  const Divider(
                    height: 28,
                  ),

                  _SummaryRow(
                    title: "Total",
                    value:
                        "Rs ${total.toStringAsFixed(0)}",
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: cartProvider.cartItems.isEmpty
                    ? null
                    : () {
                        _placeOrder(
                          context,
                          cartProvider,
                          subtotal,
                          deliveryFee,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  "Place Order • Rs ${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder(
    BuildContext context,
    CartProvider cartProvider,
    double subtotal,
    double deliveryFee,
  ) {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter your delivery address.",
          ),
        ),
      );
      return;
    }

    final orderProvider = context.read<OrderProvider>();

    orderProvider.placeOrder(
      items: cartProvider.cartItems,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      address: address,
      paymentMethod: selectedPayment,
    );

    cartProvider.clearCart();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const OrderSuccessScreen(),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final String selectedValue;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.icon,
    required this.value,
    required this.selectedValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == selectedValue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),

            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : Colors.grey,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal
                ? Colors.black
                : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 19 : 15,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? AppColors.primary
                : Colors.black,
          ),
        ),
      ],
    );
  }
}