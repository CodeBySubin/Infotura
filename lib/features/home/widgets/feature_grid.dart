import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infotura/core/routes/app_routes.dart';

class FeatureGrid extends StatelessWidget {
  final ThemeData theme;
  const FeatureGrid({super.key, required this.theme});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                context,
                theme,
                'Mark Attendance',
                'Track your daily presence',
                Icons.access_time_rounded,
                Colors.blue,
                () {
                  context.push(AppRoutes.attendance);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureCard(
                context,
                theme,
                'POS Entry',
                'Create new sale entries',
                Icons.point_of_sale_rounded,
                Colors.green,
                () {
                  context.push(AppRoutes.posEntry);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFeatureCard(
                context,
                theme,
                'Attendance History',
                'View attendance records',
                Icons.history_rounded,
                Colors.orange,
                () {
                  context.push(AppRoutes.attendanceDetail);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureCard(
                context,
                theme,
                'Sales Reports',
                'Analyze sales data',
                Icons.analytics_rounded,
                Colors.purple,
                () {
                  context.push(AppRoutes.posList);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.28,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                height: 1.3,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
