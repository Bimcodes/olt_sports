import 'package:flutter/material.dart';

import '../mvc/views/news/news_article_screen.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateString;
  final String imagePath; // Asset path

  const NewsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateString,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => NewsArticleScreen(title: title, dateString: dateString),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300], // Placeholder context color
          borderRadius: BorderRadius.circular(12),
          // Normally we use an DecorationImage here once assets are generated
          // image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            // Gradient Overlay to make text readable
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),
            // Text Content
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateString,
                    style: const TextStyle(color: Colors.white70, fontSize: 9),
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
