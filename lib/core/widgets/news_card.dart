import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:olt_sports/core/helper/format_date_time.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateString;
  final String imagePath;
  final void Function()? onTap;

  const NewsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateString,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,

                placeholder:
                    (context, url) => Container(
                      height: 140,
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),

                errorWidget:
                    (context, url, error) => Container(
                      height: 140,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
              ),
            ),
            // SizedBox(height: 12),

            /// TEXT SECTION
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    data: title,
                    style: {
                      'body': Style(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize(14),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),

                  
                  Html(
                    data: subtitle,
                    style: {
                      'body': Style(
                        color: Colors.grey[700],
                        fontSize: FontSize(12),
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),

                  // Text(
                  //   subtitle,
                  //   style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   dateString,
                  //   style: TextStyle(color: Colors.grey[500], fontSize: 10),
                  // ),
                  Html(
                    data: formatNewsDateTime(dateString),
                    style: {
                      'body': Style(
                        color: Colors.grey[500],
                        fontSize: FontSize(8),
                      ),
                    },
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
