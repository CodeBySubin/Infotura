import 'package:flutter/material.dart';
import 'package:infotura/features/point_of_sales/features/widgets/summery_items.dart';

class SummeryCard extends StatelessWidget {
  final List<dynamic> sales;
  final ThemeData theme;
  const SummeryCard({super.key, required this.sales, required this.theme});

  @override
  Widget build(BuildContext context) {
    final totalSales = sales.length;
    final totalRevenue = sales.fold<double>(
      0.0,
      (sum, sale) => sum + (sale.quantity * sale.price),
    );
    final totalItems = sales.fold<int>(
      0,
      (sum, sale) => sum + sale.quantity as int,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withValues(alpha:  0.1),
            theme.primaryColor.withValues(alpha:0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor.withValues(alpha:0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_rounded,
                color: theme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Sales Summary',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SummeryItems(
                  label: 'Total Sales',
                  value: totalSales.toString(),
                  icon: Icons.receipt_rounded,
                  theme: theme,
                ),
              ),
              Expanded(
                child: SummeryItems(
                  label: 'Total Items',
                  value: totalItems.toString(),
                  icon: Icons.inventory_rounded,
                  theme: theme,
                ),
              ),
              Expanded(
                child: SummeryItems(
                  label: 'Revenue',
                  value: '₹${totalRevenue.toStringAsFixed(2)}',
                  icon: Icons.currency_rupee_rounded,
                  theme: theme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
