import 'package:flutter/material.dart';

class VideoPlayerPlaceholder extends StatelessWidget {
  final double height;
  final bool showControls;
  final VoidCallback? onTap;

  const VideoPlayerPlaceholder({
    super.key,
    required this.height,
    this.showControls = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        color: const Color(0xFF5A5A5A), // Dark grey from screenshots
        child:
            showControls
                ? Stack(
                  children: [
                    // Center Play Button
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white70, width: 2),
                        ),
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),

                    // Bottom Left Play Status
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white70, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    // Bottom Right Play Status
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white70, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.play_arrow_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                )
                : null,
      ),
    );
  }
}
