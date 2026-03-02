import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dummy placeholder for logo image since we don't have the asset yet
            // Replace with Image.asset('assets/images/logo.png')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.greenAccent,
                  size: 40,
                ),
                const SizedBox(width: 8),
                const Text(
                  'OLT SPORTS',
                  style: TextStyle(
                    fontFamily: 'Impact', // Fallback local font
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.greenAccent,
                    shadows: [
                      Shadow(
                        color: AppColors.splashLogoShadow,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Text(
              'Pride of the game...',
              style: TextStyle(
                color: Colors.greenAccent,
                fontStyle: FontStyle.italic,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
