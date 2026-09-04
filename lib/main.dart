import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/food_repository.dart';
import 'firebase_options.dart';
import 'models/food_model.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/order_provider.dart';
import 'providers/search_provider.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FoodModel>>(
      initialData: const [],
      create: (_) => FoodRepository().watchFoods(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FavoriteProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OrderProvider(),
          ),
          ChangeNotifierProxyProvider<List<FoodModel>, SearchProvider>(
            create: (_) => SearchProvider(const []),
            update: (_, foods, searchProvider) {
              if (searchProvider == null) {
                return SearchProvider(foods);
              }

              searchProvider.updateFoods(foods);
              return searchProvider;
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Foodly',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xffFF6B35),
            ),
          ),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}