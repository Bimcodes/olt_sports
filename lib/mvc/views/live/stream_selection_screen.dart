import 'package:flutter/material.dart';

import '../../../widgets/video_player_placeholder.dart';

class StreamSelectionScreen extends StatefulWidget {
  const StreamSelectionScreen({super.key});

  @override
  State<StreamSelectionScreen> createState() => _StreamSelectionScreenState();
}

class _StreamSelectionScreenState extends State<StreamSelectionScreen> {
  bool _showQualityOverlay = false;

  void _toggleOverlay() {
    setState(() {
      _showQualityOverlay = !_showQualityOverlay;
    });
  }

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
      body: Stack(
        children: [
          Column(
            children: [
              // Interactive Video Placeholder
              VideoPlayerPlaceholder(
                height: 400, // Large height as per screenshot
                showControls: !_showQualityOverlay,
                onTap: _toggleOverlay,
              ),

              const SizedBox(height: 32),

              // Stream List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildStreamRow('Stream 1', 'SD'),
                    _buildStreamRow('Stream 2', 'SD'),
                    _buildStreamRow('Stream 3', 'HD'),
                    _buildStreamRow('Stream 4', 'HD'),
                  ],
                ),
              ),
            ],
          ),

          // Quality Overlay implementation
          if (_showQualityOverlay)
            Positioned(
              top: 0, // Just below app bar area within body
              left: 24, // Overlay appears on the far left side of video
              child: Container(
                width: 60,
                // The overlay spans some vertical height containing the options
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // A subtle shield icon
                    const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'SD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'SD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'HD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'HD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Icon(Icons.keyboard_arrow_up, color: Colors.white),
                    const SizedBox(height: 16),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    const SizedBox(height: 48), // Padding before bottom icon
                    const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStreamRow(String name, String quality) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stream Button Structure
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF516D54), // Darker green play block
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                  ),
                  child: const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Quality Text
          Text(
            quality,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
