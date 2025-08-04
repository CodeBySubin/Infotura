import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:infotura/features/attendance/data/model/attendance_model.dart';
import 'package:infotura/features/attendance/data/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/data/datasource/attendance_local_datasourece.dart';
import 'package:infotura/features/attendance/data/datasource/attendance_remote_datasource.dart';
import 'package:infotura/features/attendance/domain/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/domain/usecases/attendance_usecase.dart';
import 'package:infotura/features/attendance/presentation/bloc/attendance_bloc.dart';

import 'package:infotura/features/point_of_sales/data/datasource/firebase_datasource.dart';
import 'package:infotura/features/point_of_sales/data/datasource/hive_datasource.dart';
import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';
import 'package:infotura/features/point_of_sales/data/repository/bill_repository.dart';
import 'package:infotura/features/point_of_sales/domain/repository/repository%20.dart';
import 'package:infotura/features/point_of_sales/features/bloc/pos_bloc.dart';
import 'package:infotura/features/splash/cubit/splash_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Register Hive adapters
  Hive.registerAdapter(BillModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());

  // Open Hive boxes
  final billBox = await Hive.openBox<BillModel>('bills');
  final attendanceBox = await Hive.openBox<AttendanceModel>('attendance');

  // External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // POS
  // ✅ Core
  sl.registerLazySingleton(() => billBox);
  sl.registerLazySingleton(() => LocalBillDataSource(sl()));
  sl.registerLazySingleton(() => RemoteBillDataSource(sl()));
  sl.registerLazySingleton<BillRepository>(
    () => BillRepositoryImpl(sl(), sl()),
  );
  sl.registerFactory(() => PosBloc(sl(), sl()));

  // Attendance
  sl.registerLazySingleton(() => LocalAttendanceDataSource(attendanceBox));
  sl.registerLazySingleton(() => AttendanceRemoteDataSource(sl()));
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => MarkAttendanceUseCase(sl()));
  sl.registerFactory(() => AttendanceBloc(sl(), sl()));

  sl.registerFactory(() => SplashCubit());

  
}
