import 'package:flutter/material.dart';
import 'package:infotura/features/home/widgets/feature_grid.dart';
import 'package:infotura/features/home/widgets/header.dart';
import 'package:infotura/features/home/widgets/quic_stats.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(theme: theme),
                const SizedBox(height: 32),
                QuicStats(theme: theme),
                const SizedBox(height: 32),
                Text(
                  'Quick Actions',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                FeatureGrid(theme: theme),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
