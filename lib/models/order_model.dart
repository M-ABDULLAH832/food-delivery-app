import 'food_model.dart';

class OrderModel {
  final String id;
  final List<FoodModel> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String address;
  final String paymentMethod;
  final DateTime orderDate;
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.orderDate,
    required this.status,
  });
}