import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';

import '../../../../core/widgets/widgets.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackgroundDecorator(
      onBack: () => Navigator.pop(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reset Password?', style: AppTextStyles.authHeadline),
          const SizedBox(height: 8),
          Text('Enter your new password', style: AppTextStyles.authSubtitle),
          const SizedBox(height: 32),

          const CustomTextField(
            label: 'New Password',
            hintText: 'johndoe@example.com', // Placeholder shown in design
            isPassword: true,
          ),
          const SizedBox(height: 20),

          const CustomTextField(
            label: 'Re-enter Password',
            hintText: 'johndoe@example.com',
            isPassword: true,
          ),
          const SizedBox(height: 32),

          CustomButton(
            width: double.infinity,
            text: 'Password Reset',
            onPressed: () {
              // TODO: Execute password reset logic, then navigate back to Login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false, // Clears the stack
              );
            },
          ),
        ],
      ),
    );
  }
}
