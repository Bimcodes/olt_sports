import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../models/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image Placeholder Area
        Positioned.fill(
          child: Container(
            color: Colors.black12,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 150),
            child: Text(
              item.imagePlaceholder,
              style: const TextStyle(color: Colors.white54),
            ),
            // TODO: Uncomment once assets are provided
            // child: Image.asset(item.imagePath, fit: BoxFit.cover),
          ),
        ),
        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.backgroundGreen,
                  AppColors.lightGreenGradientEnd,
                ],
                stops: [0.4, 0.75, 1.0], // Fade matching the design
              ),
            ),
          ),
        ),
        // Text Content
        Positioned(
          left: 32,
          right: 32,
          bottom: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: 16),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
