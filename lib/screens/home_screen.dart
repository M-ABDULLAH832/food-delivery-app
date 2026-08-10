import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
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
    final searchProvider = context.watch<SearchProvider>();

    final foods = searchProvider.filteredFoods;
    final bool isFiltering = searchProvider.isFiltering;

    return Scaffold(
      backgroundColor: const Color(0xffF5F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            22,
            20,
            22,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),

              const SizedBox(height: 26),

              const SearchBarWidget(),

              const SizedBox(height: 26),

              if (!isFiltering) ...[
                const HeroBanner(),

                const SizedBox(height: 30),

                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 18),

                const CategoryList(),

                const SizedBox(height: 30),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isFiltering ? "Filtered Foods" : "Popular Foods",
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  if (!isFiltering)
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              if (foods.isEmpty)
                const _NoSearchResults()
              else
                SizedBox(
                  height: 320,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        food: foods[index],
                      );
                    },
                  ),
                ),

              if (!isFiltering) ...[
                const SizedBox(height: 32),
                const RecommendedFoodSection(),
                const SizedBox(height: 10),
              ],
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

class _NoSearchResults extends StatelessWidget {
  const _NoSearchResults();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 45,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "No food found",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Try searching with another food name.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}