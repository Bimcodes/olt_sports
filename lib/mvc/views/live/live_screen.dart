import 'package:flutter/material.dart';

import '../../../widgets/match_card.dart';
import '../../../widgets/video_player_placeholder.dart';
import 'stream_selection_screen.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed:
              () {}, // Can be wired up if Live is pushed instead of tabbed, but usually tabs don't have back arrows
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Video Player Area
            const VideoPlayerPlaceholder(height: 250),

            const SizedBox(height: 24),

            // Leagues Horizontal List
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildLeagueTab('EPL', isSelected: false),
                  _buildLeagueTab('LA LIGA', isSelected: true),
                  _buildLeagueTab('SERIE A', isSelected: true),
                  _buildLeagueTab('LIGUE 1', isSelected: true),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Match List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildLiveMatchCard(context, isHighlight: true),
                  _buildLiveMatchCard(context, isHighlight: false),
                  _buildLiveMatchCard(context, isHighlight: false),
                ],
              ),
            ),
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildLiveMatchCard(
    BuildContext context, {
    required bool isHighlight,
  }) {
    // A wrapper around MatchCard to intercept tap and go to StreamSelectionScreen
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StreamSelectionScreen()),
        );
      },
      child: AbsorbPointer(
        // Prevent inner tap from MatchCard
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: MatchCard(
            team1Logo: '',
            team1Name: 'Manchester U..',
            team2Logo: '',
            team2Name: 'Chelsea',
            dateString: 'January 6th, 2021.',
            isLive: !isHighlight, // If not highlight, it's a generic match
            isHighlight: isHighlight,
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueTab(String name, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:
            isSelected
                ? const Color(0xFF516D54)
                : Colors.white, // Custom dark green for these chips
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF516D54) : Colors.black12,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
