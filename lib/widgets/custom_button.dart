import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? suffixIcon;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color? textColor;
  final Border? border;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.suffixIcon,
    this.width,
    this.height = 48,
    this.backgroundColor = AppColors.buttonGreen,
    this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.buttonText.copyWith(
                color: textColor ?? AppColors.textColor,
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              Icon(
                suffixIcon,
                color: textColor ?? AppColors.textColor,
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
