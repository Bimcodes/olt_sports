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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:olt_sports/core/helper/format_date_time.dart';

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
              Html(
                data: title,
                style: {
                  'body': Style(
                    fontSize: FontSize(24),
                    fontWeight: FontWeight.bold,
                    // height: Height(1.3),
                    color: Colors.black87,
                  ),
                },
              ),

              const SizedBox(height: 16),

              // Publication Date
              Html(
                data: formatNewsDateTime(dateString),
                style: {
                  'body': Style(fontSize: FontSize(12), color: Colors.grey),
                },
              ),
              const SizedBox(height: 24),

              // Featured Image
              if (imagePath != null && imagePath!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    color: Colors.grey[100],
                    child:
                        imagePath!.startsWith('http')
                            ? CachedNetworkImage(
                              imageUrl: imagePath!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              placeholder:
                                  (context, url) => _buildImagePlaceholder(),
                              errorWidget:
                                  (context, url, error) =>
                                      _buildImagePlaceholder(),
                            )
                            : Image.asset(
                              imagePath!,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      _buildImagePlaceholder(),
                            ),
                  ),
                )
              else
                _buildImagePlaceholder(),
              const SizedBox(height: 24),

              const SizedBox(height: 16),

              // Article Body (Content)
              if (content != null && content!.isNotEmpty)
                Html(
                  data: content!,
                  style: {
                    "body": Style(
                      fontSize: FontSize(14),
                      lineHeight: LineHeight.number(1.6),
                      color: Colors.black54,
                    ),
                    "p": Style(
                      margin: Margins.only(bottom: 12),
                      lineHeight: LineHeight.number(1.6),
                    ),
                    "h2": Style(
                      fontSize: FontSize(20),
                      fontWeight: FontWeight.w700,
                      margin: Margins.only(top: 20, bottom: 12),
                      color: Colors.black87,
                    ),
                    "h3": Style(
                      fontSize: FontSize(18),
                      fontWeight: FontWeight.w700,
                      margin: Margins.only(top: 18, bottom: 10),
                      color: Colors.black87,
                    ),
                    "figure": Style(
                      display: Display.block,
                      alignment: Alignment.center,
                      margin: Margins.symmetric(vertical: 16),
                      textAlign: TextAlign.center,
                    ),
                    "img": Style(
                      display: Display.block,
                      alignment: Alignment.center,
                      width: Width(100, Unit.percent),
                      height: Height.auto(),
                      margin: Margins.symmetric(vertical: 8),
                    ),
                    "figcaption": Style(
                      textAlign: TextAlign.center,
                      fontSize: FontSize(12),
                      color: Colors.grey,
                      margin: Margins.only(top: 4),
                    ),
                    "a": Style(color: Colors.blue),
                  },
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
