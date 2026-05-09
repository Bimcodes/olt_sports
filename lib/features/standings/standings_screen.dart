import 'package:flutter/material.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 32,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              'OLT SPORTS',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // League Tabs
            SizedBox(
              height: 48,
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

            // Standings Table
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildTableHeader(),
                  const SizedBox(height: 8),
                  _buildTableRow(1, 'Man City', true),
                  _buildTableRow(2, 'Man Utd', true),
                  _buildTableRow(3, 'Liverpool', true),
                  _buildTableRow(4, 'Arsenal', true),
                  _buildTableRow(5, 'Tottenham', false, isYellow: true),
                  _buildTableRow(6, 'Newcastle', false, isYellow: true),
                  _buildTableRow(7, 'Aston Villa', false),
                  _buildTableRow(8, 'West Ham', false),
                  _buildTableRow(9, 'Brighton', false),
                  _buildTableRow(10, 'Wolves', false),
                  _buildTableRow(11, 'Fulham', false),
                ],
              ),
            ),
            const SizedBox(height: 48), // Bottom buffer
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        // Rank placeholder
        Container(width: 24, height: 40, color: const Color(0xFF516D54)),
        const SizedBox(width: 8),
        // Club column
        Expanded(
          flex: 4,
          child: Container(
            height: 40,
            color: const Color(0xFF516D54),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'CLUBS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Stat columns
        _buildStatHeaderCell('MP'),
        _buildStatHeaderCell('W'),
        _buildStatHeaderCell('D'),
        _buildStatHeaderCell('L'),
        _buildStatHeaderCell('P'),
      ],
    );
  }

  Widget _buildStatHeaderCell(String text) {
    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 4),
        color: const Color(0xFF516D54),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(
    int rank,
    String teamName,
    bool isTop, {
    bool isYellow = false,
  }) {
    Color rowColor;
    Color textColor;
    if (isTop) {
      rowColor = const Color(0xFF516D54).withValues(alpha: 0.9);
      textColor = Colors.white;
    } else if (isYellow) {
      rowColor = Colors.yellow.shade100;
      textColor = Colors.black87;
    } else {
      rowColor = Colors.transparent;
      textColor = Colors.black87;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // Rank
          Container(
            width: 24,
            height: 40,
            color: rowColor,
            alignment: Alignment.center,
            child: Text('$rank', style: TextStyle(color: textColor)),
          ),
          const SizedBox(width: 8),
          // Club column
          Expanded(
            flex: 4,
            child: Container(
              height: 40,
              color: rowColor,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Placeholder for circular team logo
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    teamName,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Stat columns dummy data
          _buildStatCell('18', isTop, isYellow: isYellow),
          _buildStatCell('18', isTop, isYellow: isYellow),
          _buildStatCell('18', isTop, isYellow: isYellow),
          _buildStatCell('18', isTop, isYellow: isYellow),
          _buildStatCell('18', isTop, isYellow: isYellow),
        ],
      ),
    );
  }

  Widget _buildStatCell(String text, bool isTop, {bool isYellow = false}) {
    Color cellColor;
    Color textColor;
    if (isTop) {
      cellColor = const Color(0xFF516D54).withValues(alpha: 0.9);
      textColor = Colors.white;
    } else if (isYellow) {
      cellColor = Colors.yellow.shade100;
      textColor = Colors.black87;
    } else {
      cellColor = Colors.transparent;
      textColor = Colors.black54;
    }

    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(left: 4),
        color: cellColor,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: textColor, fontSize: 12)),
      ),
    );
  }

  Widget _buildLeagueTab(String name, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color:
            !isSelected
                ? Colors.white
                : const Color(
                  0xFF516D54,
                ), // From screenshot, unselected is white (EPL), others are green
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: !isSelected ? Colors.black12 : const Color(0xFF516D54),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          color: !isSelected ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
