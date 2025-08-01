import 'package:infotura/features/attendance/presentation/screen/attendance_list_screen.dart';
import 'package:infotura/features/attendance/presentation/screen/attendance_screen.dart';
import 'package:infotura/features/home/home.dart';
import 'package:infotura/features/point_of_sales/features/screen/pos_entry_screen.dart';
import 'package:infotura/features/point_of_sales/features/screen/sales_list_screen.dart';
import 'package:infotura/features/splash/presentation/splash_screen.dart';

import 'app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
   initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.attendance,
      name: RouteNames.attendance,
      builder: (context, state) => const AttendanceScreen(),
    ),
    GoRoute(
      path: AppRoutes.attendanceDetail,
      name: RouteNames.attendanceDetail,
      builder: (context, state) => const AttendanceListScreen(),
    ),
    GoRoute(
      path: AppRoutes.posEntry,
      name: RouteNames.posEntry,
      builder: (context, state) => const PosEntryScreen(),
    ),
    GoRoute(
      path: AppRoutes.posList,
      name: RouteNames.posList,
      builder: (context, state) => const SalesListScreen(),
    ),
      GoRoute(
      path: AppRoutes.home,
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
}