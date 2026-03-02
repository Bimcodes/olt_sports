import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';
import 'order_summary_screen.dart';

class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({super.key});

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
              Text('Shipping Details', style: AppTextStyles.authHeadline),
              const SizedBox(height: 8),
              Text(
                'Kindly fill in your details correctly',
                style: AppTextStyles.authSubtitle,
              ),
              const SizedBox(height: 32),

              _buildInputField('Full Name', 'John Doe...'),
              _buildInputField('Email', 'johndoe@gmail.com'),
              _buildInputField('Phone Number', '+234...'),
              _buildInputField('Customization Name', 'Jakande'),
              _buildInputField('Delivery Address', 'Type here...'),
              _buildInputField('Nearest Bus/stop', 'Placeholder'),
              _buildInputField('Additional Information', 'Type here...'),

              const SizedBox(height: 32),

              // Custom Continue Button with green trailing arrow structure
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderSummaryScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: Colors.black54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF516D54),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF516D54)),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 8),
            ),
          ),
        ],
      ),
    );
  }
}
