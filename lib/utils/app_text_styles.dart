import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.heading,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.heading,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.heading,
  );


  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: AppColors.body,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.body,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: AppColors.subtitle,
  );


  static const TextStyle price = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );


  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );


  static const TextStyle rating = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.heading,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: AppColors.subtitle,
  );
}