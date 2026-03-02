import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';
import '../../../widgets/video_player_placeholder.dart';

class HighlightsScreen extends StatelessWidget {
  const HighlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Highlighted Matches',
                style: AppTextStyles.authHeadline.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),

            // Highlight Feed
            _buildHighlightItem(),
            _buildHighlightItem(),
            _buildHighlightItem(),

            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightItem() {
    return Column(
      children: [
        // Teams and Date
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team 1
                  _buildLogoAndName('Nigeria', Colors.green),
                  // VS
                  Text(
                    'Vs',
                    style: AppTextStyles.authSubtitle.copyWith(fontSize: 16),
                  ),
                  // Team 2
                  _buildLogoAndName('Ghana', Colors.red),
                ],
              ),
              const SizedBox(height: 24),
              // Date
              Text(
                'January 5th, 2022.',
                style: AppTextStyles.authSubtitle.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Large Video Player for the highlight
        const VideoPlayerPlaceholder(height: 250, showControls: true),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildLogoAndName(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.authSubtitle.copyWith(fontSize: 12)),
      ],
    );
  }
}
