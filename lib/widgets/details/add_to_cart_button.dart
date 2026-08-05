import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class AddToCartButton extends StatelessWidget {
  final double price;
  final VoidCallback onPressed;

  const AddToCartButton({
    super.key,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(22),

      child: SizedBox(
        width: double.infinity,
        height: 62,

        child: ElevatedButton(
          onPressed: onPressed,

          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 8,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: const [

                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),

                  SizedBox(width: 12),

                  Text(
                    "Add to Cart",
                    style: AppTextStyles.button,
                  ),
                ],
              ),

              Text(
                "Rs. ${price.toStringAsFixed(0)}",
                style: AppTextStyles.button,
              ),
            ],
          ),
        ),
      ),
    );
  }
}