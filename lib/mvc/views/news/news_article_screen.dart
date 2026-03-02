import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class NewsArticleScreen extends StatelessWidget {
  final String title;
  final String dateString;
  // Will receive full article text, bold text, and image path

  const NewsArticleScreen({
    super.key,
    required this.title,
    required this.dateString,
  });

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Headline
              Text(
                'Nigeria should host the FIFA World Cup, says Patrice Motsepe.',
                style: AppTextStyles.authHeadline.copyWith(
                  fontSize: 24,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),

              // Featured Image Placeholder
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.amber, // Placeholder for the yellow/green image
                alignment: Alignment.center,
                child: const Text(
                  'Featured Image Asset Required',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 24),

              // Summary Text (Bold)
              Text(
                'CAF President Dr Patrice Motsepe believes Nigeria should submit a bid for the FIFA World Cup',
                style: AppTextStyles.authSubtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Article Body
              Text(
                'President of the Confederation of African Football, CAF, Dr Patrice Motsepe has said Nigeria should submit a bid to hos the FIFA World Cup.\n'
                'The South Africa businessman Patrice Motsepe said this when responding to questions in an interview ahead of the curtain drawer of the African Cup of Nations AFCON in Ivory Coast.\n'
                'Patrice Motsepe watched on from the VIP section, not for the first time since the start of the tournament, as the Super Eagles of Nigeria defeated his nation South Africa to book a place in Sunday\'s final.\n'
                'Despite the result in Bouake, Motsepe must have been really proud of the Bafana Bafana team, who made it to the last four only for the fourth time in the country\'s history, and first time since 2000 in Nigeria.',
                style: AppTextStyles.authSubtitle.copyWith(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
