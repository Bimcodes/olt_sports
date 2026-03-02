import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/auth_background_decorator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../main/main_layout.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundDecorator(
      onBack: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login', style: AppTextStyles.authHeadline),
          const SizedBox(height: 8),
          Text('Welcome back', style: AppTextStyles.authSubtitle),
          const SizedBox(height: 32),

          const CustomTextField(
            label: 'Email Address',
            hintText: 'johndoe@example.com',
          ),
          const SizedBox(height: 20),

          const CustomTextField(
            label: 'Password',
            hintText: 'johndoe@example.com', // As seen in screenshot
            isPassword: true,
          ),
          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot password?',
                style: AppTextStyles.inputLabel.copyWith(
                  color: AppColors.backgroundGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          CustomButton(
            width: double.infinity,
            text: 'Login',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainLayout()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.inputBorderColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Or',
                  style: AppTextStyles.authSubtitle.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: AppColors.inputBorderColor)),
            ],
          ),
          const SizedBox(height: 32),

          CustomButton(
            width: double.infinity,
            backgroundColor: Colors.transparent,
            border: Border.all(color: AppColors.inputBorderColor),
            textColor: Colors.black54,
            text: 'Continue with Google',
            // Using a simple icon here, but normally you'd use a Google asset or specialized icon
            suffixIcon: null, // Google icon would go here usually as a prefix
            onPressed: () {
              // TODO: Implement Google login
            },
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: AppTextStyles.inputLabel.copyWith(color: Colors.black54),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: Text(
                  'Sign Up',
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
