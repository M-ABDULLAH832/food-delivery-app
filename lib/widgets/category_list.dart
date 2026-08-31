import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/search_provider.dart';
import '../utils/app_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        final categories = searchProvider.categories;

        return SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (content, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected =
                  searchProvider.selectedCategory == category;

              return GestureDetector(
                onTap: () {
                  searchProvider.selectCategory(category);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.heading,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}