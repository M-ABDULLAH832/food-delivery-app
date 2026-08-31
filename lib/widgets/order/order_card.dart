import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../utils/app_colors.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final date =
        "${order.orderDate.day.toString().padLeft(2, '0')}/"
        "${order.orderDate.month.toString().padLeft(2, '0')}/"
        "${order.orderDate.year}";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: order.items.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                final food = order.items[index];

                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFF4EC),
                    borderRadius: BorderRadius.circular(14),
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
                        size: 32,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Text(
                "${order.items.length} item${order.items.length == 1 ? '' : 's'}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              const Text(
                "Total ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              Text(
                "Rs ${order.total.toStringAsFixed(0)}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Divider(height: 1),

          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  order.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.payment_rounded,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(width: 6),
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
}