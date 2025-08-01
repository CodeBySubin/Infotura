import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infotura/core/widgets/loader.dart';
import 'package:infotura/features/point_of_sales/features/widgets/empty_sales.dart';
import 'package:infotura/features/point_of_sales/features/widgets/sales_list_items.dart';
import 'package:infotura/features/point_of_sales/features/widgets/summery_card.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_bloc.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_event.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_state.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Today',
    'This Week',
    'This Month',
  ];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("ssssssssssssssssssssssssssssssssssss");
    context.read<PosBloc>().add(LoadSalesList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Sales History',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              context.read<PosBloc>().add(const LoadSalesList());
            },
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.filter_list_rounded,
                      size: 20,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Filter by Date',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filterOptions.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          backgroundColor: Colors.grey[100],
                          selectedColor: theme.primaryColor.withValues(
                            alpha: 0.2,
                          ),
                          checkmarkColor: theme.primaryColor,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? theme.primaryColor
                                : Colors.grey[700],
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? theme.primaryColor.withValues(alpha: 0.3)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocBuilder<PosBloc, PosState>(
              builder: (context, state) {
                return state.when(
                  initial: () => EmptySales(
                    icon: Icons.point_of_sale_rounded,
                    title: 'Getting Ready',
                    subtitle: 'Initializing sales data...',
                  ),
                  loading: () => loader(),
                  loaded: (sales) {
                    if (sales.isEmpty) {
                      return EmptySales(
                        icon: Icons.receipt_long_rounded,
                        title: 'No Sales Records',
                        subtitle: 'Start by creating your first sale entry!',
                      );
                    }

                    final filteredSales = _filterAndSearchSales(sales);

                    if (filteredSales.isEmpty) {
                      return EmptySales(
                        icon: Icons.search_off_rounded,
                        title: 'No Results Found',
                        subtitle: _searchQuery.isNotEmpty
                            ? 'No products match "$_searchQuery"'
                            : 'No sales found for $_selectedFilter',
                      );
                    }

                    return Column(
                      children: [
                        SummeryCard(sales: filteredSales, theme: theme),
                        Expanded(
                          child: SalesListItems(
                            sales: filteredSales,
                            theme: theme,
                          ),
                        ),
                      ],
                    );
                  },
                  error: (message) => _buildErrorState(context, message),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<PosBloc>().add(const LoadSalesList());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _filterAndSearchSales(List<dynamic> sales) {
    var filteredSales = sales;
    final now = DateTime.now();
    switch (_selectedFilter) {
      case 'Today':
        filteredSales = sales.where((sale) {
          final saleDate = sale.dateTime as DateTime;
          return saleDate.year == now.year &&
              saleDate.month == now.month &&
              saleDate.day == now.day;
        }).toList();
        break;
      case 'This Week':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filteredSales = sales.where((sale) {
          final saleDate = sale.dateTime as DateTime;
          return saleDate.isAfter(
            startOfWeek.subtract(const Duration(days: 1)),
          );
        }).toList();
        break;

      case 'This Month':
        filteredSales = sales.where((sale) {
          final saleDate = sale.dateTime as DateTime;
          return saleDate.year == now.year && saleDate.month == now.month;
        }).toList();
        break;
    }
    if (_searchQuery.isNotEmpty) {
      filteredSales = filteredSales.where((sale) {
        return sale.productName.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    return filteredSales;
  }
}
