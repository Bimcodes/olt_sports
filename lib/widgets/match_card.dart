import 'package:flutter/material.dart';

import '../mvc/views/match/match_details_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MatchCard extends StatelessWidget {
  final String team1Logo; // Will be asset path
  final String team1Name;
  final String team2Logo; // Will be asset path
  final String team2Name;
  final String dateString;
  final bool isLive;
  final bool isHighlight;

  const MatchCard({
    super.key,
    required this.team1Logo,
    required this.team1Name,
    required this.team2Logo,
    required this.team2Name,
    required this.dateString,
    this.isLive = false,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MatchDetailsScreen(isLive: isLive)),
        );
      },
      child: Container(
        width: 320,
        margin: const EdgeInsets.only(left: 16, right: 8, bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFBF2), // Pale yellow background from design
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Teams Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Team 1
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        color: Colors.red[200],
                      ), // Placeholder
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          team1Name,
                          style: AppTextStyles.authSubtitle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Vs',
                    style: AppTextStyles.authHeadline.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Team 2
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          team2Name,
                          style: AppTextStyles.authSubtitle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 24,
                        height: 24,
                        color: Colors.blue[200],
                      ), // Placeholder
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Date Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dateString,
                    style: AppTextStyles.authSubtitle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isHighlight
                        ? const Color(0xFF516D54)
                        : AppColors
                            .backgroundGreen, // Darker green for highlights
                borderRadius: BorderRadius.circular(8),
                border:
                    isHighlight
                        ? Border.all(color: Colors.white, width: 1)
                        : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isHighlight || isLive) ...[
                    Icon(
                      isHighlight
                          ? Icons.play_arrow_outlined
                          : Icons.play_circle_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    isHighlight
                        ? 'Highlights'
                        : (isLive ? 'Live' : 'Coming Soon'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
