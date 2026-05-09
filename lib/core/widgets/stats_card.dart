import 'package:flutter/material.dart';

import 'stat_row.dart';

class StatsCard extends StatelessWidget {
  final List<StatRow> statRows;

  const StatsCard({super.key, required this.statRows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6E3D4), // Pale green from the design
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(children: statRows),
    );
  }
}
