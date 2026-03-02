import 'package:flutter/material.dart';

import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/auth_background_decorator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundDecorator(
      onBack: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Forgot Password?', style: AppTextStyles.authHeadline),
          const SizedBox(height: 8),
          Text('Enter your email address', style: AppTextStyles.authSubtitle),
          const SizedBox(height: 32),

          const CustomTextField(
            label: 'Email Address',
            hintText: 'johndoe@example.com',
          ),
          const SizedBox(height: 32),

          CustomButton(
            width: double.infinity,
            text: 'Continue',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OtpVerificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
