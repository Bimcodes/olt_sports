import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/auth_background_decorator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../main/main_layout.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundDecorator(
      // No back button on signup typically if it's the start, but we can add one if needed by setting onBack
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ), // Extra padding from top since no back button
          Text('Create Account', style: AppTextStyles.authHeadline),
          const SizedBox(height: 32),

          const CustomTextField(label: 'Name', hintText: 'John Doe'),
          const SizedBox(height: 20),

          const CustomTextField(
            label: 'Email Address',
            hintText: 'johndoe@example.com',
          ),
          const SizedBox(height: 20),

          const CustomTextField(
            label: 'Password',
            hintText: 'johndoe@example.com',
            isPassword: true,
          ),
          const SizedBox(height: 20),

          const CustomTextField(
            label: 'Confirm Password',
            hintText: 'johndoe@example.com',
            isPassword: true,
          ),
          const SizedBox(height: 32),

          Center(
            child: RichText(
              text: TextSpan(
                text: 'By continuing, you agree to our ',
                style: AppTextStyles.inputLabel.copyWith(color: Colors.black54),
                children: [
                  TextSpan(
                    text: 'terms of service',
                    style: AppTextStyles.inputLabel.copyWith(
                      color: AppColors.backgroundGreen,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            // Handle terms tap
                          },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          CustomButton(
            width: double.infinity,
            text: 'Sign Up',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainLayout()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: AppTextStyles.inputLabel.copyWith(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  'Login here',
                  style: AppTextStyles.inputLabel.copyWith(
                    color: AppColors.backgroundGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
