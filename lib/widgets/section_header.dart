import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTapViewAll;
  final bool showArrowOnly;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onTapViewAll,
    this.showArrowOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.authHeadline.copyWith(fontSize: 18)),
          GestureDetector(
            onTap: onTapViewAll,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  showArrowOnly
                      ? const Icon(Icons.chevron_right, size: 20)
                      : Text(
                        'View All',
                        style: AppTextStyles.authSubtitle.copyWith(
                          fontSize: 12,
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
