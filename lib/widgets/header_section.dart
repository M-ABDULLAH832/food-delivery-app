import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "👋 Hello Abdullah",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.subtitle,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 8),

              Text(
                "Find Your\nFavorite Food 🍔",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),

        // Notification Button
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primary,
            size: 28,
          ),
        ),
      ],
    );
  }
}