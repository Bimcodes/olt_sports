import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/match_card.dart';
import '../../../widgets/news_card.dart';
import '../../../widgets/section_header.dart';
import '../news/news_list_screen.dart';
import '../standings/standings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.authBackground, // Using the white background from Auth
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: Center(
          child: Image.asset(
            'assets/splash_screen.png', // We'll need this asset
            height: 32,
            errorBuilder:
                (context, error, stackTrace) => const Text(
                  'OLT SPORTS',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 200,
              width: double.infinity,
              alignment: Alignment.center, // Placeholder for Hero Graphic
              child: Image.asset('assets/home_screen.png', fit: BoxFit.cover),
              // child: const Text(
              //   'Hero Banner Asset Required',
              //   style: TextStyle(color: Colors.black54),
              // ),
            ),
            const SizedBox(height: 16),

            // Leagues Horizontal List
            // Leagues Row Header with Standings link
            SectionHeader(
              title: 'Leagues',
              onTapViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StandingsScreen()),
                );
              },
            ),

            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildLeagueTab('EPL', isSelected: true),
                  _buildLeagueTab('LA LIGA', isSelected: false),
                  _buildLeagueTab('SERIE A', isSelected: false),
                  _buildLeagueTab('LIGUE 1', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Matches Section
            SectionHeader(title: 'Upcoming Matches', onTapViewAll: () {}),
            SizedBox(
              height: 180, // Height for MatchCards + shadow
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none, // Allow shadows to be visible
                children: const [
                  MatchCard(
                    team1Logo: '',
                    team1Name: 'Manchester U..',
                    team2Logo: '',
                    team2Name: 'Chelsea',
                    dateString: 'January 6th, 2021.',
                    isLive: true,
                  ),
                  MatchCard(
                    team1Logo: '',
                    team1Name: 'Manchester U..',
                    team2Logo: '',
                    team2Name: 'Chelsea',
                    dateString: 'January 6th, 2021.',
                    isLive: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Top Stories Section
            SectionHeader(
              title: 'Top Stories',
              onTapViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => const NewsListScreen(
                          title: 'Top Stories',
                          hasPreviousSection: true,
                        ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75, // Taller cards
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const NewsCard(
                    title: 'EPL 2023/2024',
                    subtitle:
                        'Nigeria should host the FIFA World Cup says Patrice Motsepe.',
                    dateString: 'January 5th , 2023.',
                    imagePath: '', // Require asset
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Shop Jersey Section
            SectionHeader(
              title: 'Shop Jersey',
              onTapViewAll: () {},
              showArrowOnly: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      color: Colors.grey[200], // Placeholder
                      alignment: Alignment.center,
                      child: const Text(
                        'Jersey 1',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 150,
                      color: Colors.grey[200], // Placeholder
                      alignment: Alignment.center,
                      child: const Text(
                        'Jersey 2',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Transfer News Section
            SectionHeader(
              title: 'Transfer News',
              onTapViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => const NewsListScreen(
                          title: 'Transfer News',
                          hasPreviousSection: false,
                        ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: 4, // Shows 4 items
                itemBuilder: (context, index) {
                  return const NewsCard(
                    title: 'EPL 2023/2024',
                    subtitle:
                        'Nigeria should host the FIFA World Cup says Patrice Motsepe.',
                    dateString: 'January 5th , 2023.',
                    imagePath: '', // Require asset
                  );
                },
              ),
            ),
            const SizedBox(height: 48), // Bottom padding for nav bar clearance
          ],
        ),
      ),
    );
  }

  Widget _buildLeagueTab(String name, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.backgroundGreen : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.backgroundGreen : Colors.black12,
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
