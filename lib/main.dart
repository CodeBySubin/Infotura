import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infotura/core/constants/app_colors.dart';
import 'package:infotura/core/constants/app_strings.dart';
import 'package:infotura/core/di/di.dart';
import 'package:infotura/core/routes/route_genarator.dart';
import 'package:infotura/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:infotura/features/attendance/presentation/screen/attendance_screen.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_bloc.dart';
import 'package:infotura/features/splash/cubit/splash_bloc.dart';
import 'package:infotura/features/status/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PosBloc>(create: (_) => sl<PosBloc>()),
        BlocProvider<AttendanceBloc>(create: (_) => sl<AttendanceBloc>()),
        BlocProvider<SplashCubit>(
          create: (_) => sl<SplashCubit>()..initialize(),
        ),
        BlocProvider(create: (_) => InternetCubit()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
