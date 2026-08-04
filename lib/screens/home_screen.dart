import 'package:flutter/material.dart';

import '../data/food_data.dart';
import '../widgets/category_list.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/food_card.dart';
import '../widgets/header_section.dart';
import '../widgets/hero_banner.dart';
import '../widgets/recommended_food_section.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),

              const SizedBox(height: 30),

              const SearchBarWidget(),

              const SizedBox(height: 30),

              const HeroBanner(),

              const SizedBox(height: 30),

              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const CategoryList(),

              const SizedBox(height: 30),

              const Text(
                "Popular Foods",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    return FoodCard(
                      food: foodList[index],
                    );
                  },
                ),
              ),

              const SizedBox(height: 35),

              const RecommendedFoodSection(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}