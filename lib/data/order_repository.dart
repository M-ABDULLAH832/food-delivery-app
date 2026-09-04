import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_model.dart';
import '../models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> saveOrder({
    required String userId,
    required OrderModel order,
  }) async {
    await _firestore
        .collection('orders')
        .doc(order.id)
        .set({
      'userId': userId,
      'orderId': order.id,
      'items': order.items.map((food) {
        return {
          'name': food.name,
          'image': food.image,
          'price': food.price,
          'rating': food.rating,
          'time': food.time,
          'description': food.description,
          'calories': food.calories,
          'category': food.category,
          'quantity': food.quantity,
        };
      }).toList(),
      'subtotal': order.subtotal,
      'deliveryFee': order.deliveryFee,
      'total': order.total,
      'address': order.address,
      'paymentMethod': order.paymentMethod,
      'orderDate': Timestamp.fromDate(order.orderDate),
      'status': order.status,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<OrderModel>> watchOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final orders = snapshot.docs.map((doc) {
        final data = doc.data();

        final items =
            (data['items'] as List<dynamic>? ?? [])
                .map((item) {
          final food =
              Map<String, dynamic>.from(item);

          return FoodModel(
            name: food['name'] ?? '',
            image: food['image'] ?? '',
            price: (food['price'] as num?)?.toDouble() ?? 0,
            rating:
                (food['rating'] as num?)?.toDouble() ?? 0,
            time: food['time'] ?? '',
            description: food['description'] ?? '',
            calories:
                (food['calories'] as num?)?.toInt() ?? 0,
            category: food['category'] ?? '',
            quantity:
                (food['quantity'] as num?)?.toInt() ?? 0,
          );
        }).toList();

        final timestamp = data['orderDate'] as Timestamp?;

        return OrderModel(
          id: data['orderId'] ?? doc.id,
          items: items,
          subtotal:
              (data['subtotal'] as num?)?.toDouble() ?? 0,
          deliveryFee:
              (data['deliveryFee'] as num?)?.toDouble() ?? 0,
          total: (data['total'] as num?)?.toDouble() ?? 0,
          address: data['address'] ?? '',
          paymentMethod: data['paymentMethod'] ?? '',
          orderDate:
              timestamp?.toDate() ?? DateTime.now(),
          status: data['status'] ?? 'Confirmed',
        );
      }).toList();

      orders.sort(
        (a, b) => b.orderDate.compareTo(a.orderDate),
      );

      return orders;
    });
  }
}