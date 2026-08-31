import 'package:flutter/foundation.dart';

import '../models/food_model.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return List.unmodifiable(_orders);
  }

  void placeOrder({
    required List<FoodModel> items,
    required double subtotal,
    required double deliveryFee,
    required String address,
    required String paymentMethod,
  }) {
    final order = OrderModel(
      id: _generateOrderId(),
      items: items
          .map(
            (food) => FoodModel(
              name: food.name,
              image: food.image,
              price: food.price,
              rating: food.rating,
              time: food.time,
              description: food.description,
              calories: food.calories,
              category: food.category,
              quantity: food.quantity,
            ),
          )
          .toList(),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: subtotal + deliveryFee,
      address: address,
      paymentMethod: paymentMethod,
      orderDate: DateTime.now(),
      status: "Confirmed",
    );

    _orders.insert(0, order);

    notifyListeners();
  }

  String _generateOrderId() {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    return "FD${timestamp.toString().substring(
          timestamp.toString().length - 6,
        )}";
  }
}