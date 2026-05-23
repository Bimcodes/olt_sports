// =============================================================================
// NEWS ARTICLE SCREEN
// =============================================================================
//
// Displays a single full news article with:
// - Article title
// - Featured image
// - Summary (excerpt)
// - Full content
//
// Can be enhanced later to receive article data via navigation parameters
// =============================================================================

import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import 'presentation/application/news_providers.dart';

/// Single News Article Screen
///
/// Displays full article details
/// Can be improved to receive article from NewsCard tap
class NewsArticleScreen extends StatelessWidget {
  final String title;
  final String dateString;
  final String? content;
  final String? excerpt;
  final String? imagePath;

  const NewsArticleScreen({
    super.key,
    required this.title,
    required this.dateString,
    this.content,
    this.excerpt,
    this.imagePath,
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
                title,
                style: AppTextStyles.authHeadline.copyWith(
                  fontSize: 24,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),

              // Date
              Text(
                dateString,
                style: AppTextStyles.authSubtitle.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),

              // Featured Image
              if (imagePath != null && imagePath!.isNotEmpty)
                Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: imagePath!.startsWith('http')
                      ? Image.network(
                          imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildImagePlaceholder(),
                        )
                      : Image.asset(
                          imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildImagePlaceholder(),
                        ),
                )
              else
                _buildImagePlaceholder(),
              const SizedBox(height: 24),

              // Summary Text (Excerpt - Bold)
              if (excerpt != null && excerpt!.isNotEmpty)
                Text(
                  excerpt!,
                  style: AppTextStyles.authSubtitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                )
              else
                const SizedBox.shrink(),
              const SizedBox(height: 16),

              // Article Body (Content)
              if (content != null && content!.isNotEmpty)
                Text(
                  content!,
                  style: AppTextStyles.authSubtitle.copyWith(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black54,
                  ),
                )
              else
                const Text('No content available for this article.'),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  /// Build a placeholder for when image is not available
  Widget _buildImagePlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported,
        size: 48,
        color: Colors.grey,
      ),
    );
  }
}
