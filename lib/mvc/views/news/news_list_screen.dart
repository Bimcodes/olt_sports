import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';
import '../../../widgets/news_card.dart';

class NewsListScreen extends StatelessWidget {
  final String title;
  final bool
  hasPreviousSection; // Determines if we show the 'Previous' header layout

  const NewsListScreen({
    super.key,
    required this.title,
    this.hasPreviousSection = false,
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
              Text(
                title,
                style: AppTextStyles.authHeadline.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 24),

              // First Grid (Either the only grid, or the 'Current' grid)
              _buildNewsGrid(hasPreviousSection ? 4 : 6),

              if (hasPreviousSection) ...[
                const SizedBox(height: 32),
                Text(
                  'Previous',
                  style: AppTextStyles.authHeadline.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 24),
                _buildNewsGrid(2),
              ],

              const SizedBox(height: 48), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsGrid(int itemCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.70, // Matches height in screenshots
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const NewsCard(
          title: 'EPL 2023/2024',
          subtitle:
              'Nigeria should host the FIFA World Cup, says Patrice Motsepe.',
          dateString: 'January 5th, 2022.',
          imagePath: '', // Require asset
        );
      },
    );
  }
}
