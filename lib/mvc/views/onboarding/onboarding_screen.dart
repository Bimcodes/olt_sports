import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../controllers/onboarding_controller.dart';
import '../auth/login_screen.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingController _controller = OnboardingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreen,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              PageView.builder(
                controller: _controller.pageController,
                itemCount: _controller.items.length,
                onPageChanged: _controller.onPageChanged,
                itemBuilder: (context, index) {
                  return OnboardingPage(item: _controller.items[index]);
                },
              ),
              // Top Right Skip Button
              if (_controller.currentIndex < _controller.items.length - 1)
                Positioned(
                  top: 60,
                  right: 20,
                  child: GestureDetector(
                    onTap: _controller.skip,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text('Skip', style: AppTextStyles.skipText),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              // Dots fixed position centered
              Positioned(
                bottom: 110,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _controller.items.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 4,
                      width: _controller.currentIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color:
                            _controller.currentIndex == index
                                ? AppColors.activeDotColor
                                : AppColors.inactiveDotColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Control Buttons
              Positioned(
                bottom: 40,
                left: 20,
                right: 20,
                child:
                    _controller.currentIndex < _controller.items.length - 1
                        ? Align(
                          alignment: Alignment.centerRight,
                          child: CustomButton(
                            text: 'Next',
                            suffixIcon: Icons.arrow_forward_ios,
                            onPressed: _controller.next,
                          ),
                        )
                        : CustomButton(
                          width: double.infinity,
                          text: 'Let\'s get Started',
                          suffixIcon: Icons.arrow_forward,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
