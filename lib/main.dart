import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/food_data.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/order_provider.dart';
import 'providers/search_provider.dart';
import 'screens/main_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(foodList),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food Delivery",
        theme: AppTheme.lightTheme,
        home: const MainScreen(),
      ),
    );
  }
}