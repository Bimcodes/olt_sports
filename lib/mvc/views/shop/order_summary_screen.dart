import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';
import 'card_payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary', style: AppTextStyles.authHeadline),
              const SizedBox(height: 32),

              _buildSummaryRow('Subtotal', '₦0,000'),
              const SizedBox(height: 16),
              _buildSummaryRow('Delivery Fee', '₦0,000'),
              const SizedBox(height: 24),
              _buildSummaryRow('Total', '₦0,000', isBold: true),

              const SizedBox(height: 48),

              Text('Payment Method', style: AppTextStyles.authHeadline),
              const SizedBox(height: 24),

              // Payment Methods
              _buildPaymentOption(
                context,
                title: 'Card Payment',
                iconOrLabel: 'VISA',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CardPaymentScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildPaymentOption(
                context,
                title: 'Transfer Payment',
                onTap: () {
                  // Standard placeholder for transfer flow
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transfer initiated...')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold ? Colors.black87 : Colors.black87,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
    BuildContext context, {
    required String title,
    String? iconOrLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.green.shade100.withValues(
                alpha: 0.5,
              ), // Soft green background
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // White circular placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                // Arrow box
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.chevron_right, color: Colors.black87),
                ),
              ],
            ),
          ),

          if (iconOrLabel != null) // Visa logo simulation
            Positioned(
              top: -12,
              right: 32,
              child: Text(
                iconOrLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
