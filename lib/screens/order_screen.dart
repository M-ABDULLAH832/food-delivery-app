import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order_model.dart';
import '../providers/order_provider.dart';
import '../utils/app_colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final orders = orderProvider.orders;

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
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: orders.isEmpty
          ? const _EmptyOrders()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                25,
              ),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _OrderCard(
                  order: orders[index],
                );
              },
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderModel order;

  const _OrderCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Order #${order.id}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            _formatDate(order.orderDate),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 18),

          ...order.items.map(
            (food) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFF4EC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        food.image,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return const Icon(
                            Icons.fastfood_rounded,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Qty: ${food.quantity}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "Rs ${(food.price * food.quantity).toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const Divider(height: 20),

          _OrderInfoRow(
            title: "Subtotal",
            value:
                "Rs ${order.subtotal.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 8),

          _OrderInfoRow(
            title: "Delivery Fee",
            value:
                "Rs ${order.deliveryFee.toStringAsFixed(0)}",
          ),

          const SizedBox(height: 8),

          _OrderInfoRow(
            title: "Total",
            value:
                "Rs ${order.total.toStringAsFixed(0)}",
            isTotal: true,
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.address,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.payment_outlined,
                size: 19,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                order.paymentMethod,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} • "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}

class _OrderInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _OrderInfoRow({
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
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
            color: isTotal
                ? Colors.black
                : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
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

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

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
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: 0.10,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              "No Orders Yet",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your placed orders will appear here.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}