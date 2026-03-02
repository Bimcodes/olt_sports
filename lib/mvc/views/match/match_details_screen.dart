import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../widgets/stat_row.dart';
import '../../../../widgets/stats_card.dart';

class MatchDetailsScreen extends StatelessWidget {
  final bool isLive;

  // Placeholder for data injection. Normally this would receive a Match object.
  const MatchDetailsScreen({super.key, this.isLive = false});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Competition Logo (CAF Placeholder)
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundGreen,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'CAF',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Match Header (Logos and VS)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Team 1 Logo
                  _buildLargeLogoPlaceholder(Colors.green),
                  // VS Text
                  Text(
                    'VS',
                    style: AppTextStyles.authSubtitle.copyWith(fontSize: 16),
                  ),
                  // Team 2 Logo
                  _buildLargeLogoPlaceholder(Colors.red),
                ],
              ),
              const SizedBox(height: 24),

              // Match Info
              Text(
                'Old Trafford Sta...',
                style: AppTextStyles.authSubtitle.copyWith(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Jan 25th, 2021',
                style: AppTextStyles.authSubtitle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),

              // Live / Time status
              if (isLive)
                Text(
                  'Live',
                  style: AppTextStyles.authSubtitle.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                )
              else
                Text(
                  '14:00 WAT',
                  style: AppTextStyles.authSubtitle.copyWith(
                    color: Colors.black38,
                    fontSize: 12,
                  ),
                ),

              const SizedBox(height: 32),

              // Teams Strip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFD6E3D4,
                  ).withValues(alpha: 0.6), // Pale green strip
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nigeria',
                      style: AppTextStyles.authSubtitle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Ghana',
                      style: AppTextStyles.authSubtitle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // HEAD TO HEAD title
              Text(
                'HEAD   TO   HEAD',
                style: AppTextStyles.authHeadline.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // First Stats Card
              const StatsCard(
                statRows: [
                  StatRow(
                    label: 'Played',
                    team1Value: 'Games',
                    team2Value: '22',
                  ), // Using 'Games' based on screenshot
                  StatRow(label: 'Wins', team1Value: '13', team2Value: '8'),
                  StatRow(label: 'Draws', team1Value: '2', team2Value: '2'),
                  StatRow(label: 'Losses', team1Value: '8', team2Value: '13'),
                ],
              ),
              const SizedBox(height: 16),

              // Second Stats Card
              const StatsCard(
                statRows: [
                  StatRow(label: 'Titles', team1Value: '2', team2Value: '2'),
                  StatRow(
                    label: 'Ranking',
                    team1Value: '15th',
                    team2Value: '22nd',
                  ),
                ],
              ),
              const SizedBox(height: 48), // Padding
            ],
          ),
        ),
      ),
    );
  }

  // Helper for the large placeholder logos with nice shadows
  Widget _buildLargeLogoPlaceholder(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2), // Light background
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4), // White border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
