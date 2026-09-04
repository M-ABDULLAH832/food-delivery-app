import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../data/order_repository.dart';
import '../models/food_model.dart';
import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderModel> _orders = [];

  final OrderRepository _orderRepository = OrderRepository();

  StreamSubscription<List<OrderModel>>? _ordersSubscription;
  StreamSubscription<User?>? _authSubscription;

  List<OrderModel> get orders {
    return List.unmodifiable(_orders);
  }

  OrderProvider() {
    _authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      _listenToOrders(user);
    });
  }

  void _listenToOrders(User? user) {
    _ordersSubscription?.cancel();

    _orders.clear();
    notifyListeners();

    if (user == null) {
      return;
    }

    _ordersSubscription =
        _orderRepository.watchOrders(user.uid).listen((orders) {
      _orders
        ..clear()
        ..addAll(orders);

      notifyListeners();
    });
  }

  Future<void> placeOrder({
    required List<FoodModel> items,
    required double subtotal,
    required double deliveryFee,
    required String address,
    required String paymentMethod,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

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
      status: 'Confirmed',
    );

    await _orderRepository.saveOrder(
      userId: user.uid,
      order: order,
    );
  }

  String _generateOrderId() {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    return 'FD${timestamp.toString().substring(
          timestamp.toString().length - 6,
        )}';
  }

  @override
  void dispose() {
    _ordersSubscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}