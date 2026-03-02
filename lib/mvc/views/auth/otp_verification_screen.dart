import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/auth_background_decorator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/otp_input_field.dart';
import 'reset_password_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundDecorator(
      onBack: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('OTP Verification', style: AppTextStyles.authHeadline),
          const SizedBox(height: 8),
          Text(
            'Enter the verification code we just sent to your email address',
            style: AppTextStyles.authSubtitle,
          ),
          const SizedBox(height: 32),

          OtpInputField(
            onCompleted: (otp) {
              // Could automatically verify here
            },
          ),
          const SizedBox(height: 32),

          CustomButton(
            width: double.infinity,
            text: 'Continue',
            onPressed: () {
              // Verify OTP then navigate to reset password
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
              );
            },
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                // Handle resend OTP logic
              },
              child: Text(
                'Didn\'t get a code? Resend OTP',
                style: AppTextStyles.inputLabel.copyWith(
                  color: AppColors.backgroundGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
