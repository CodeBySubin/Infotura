// attendance_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:infotura/features/attendance/domain/usecases/attendance_usecase.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final MarkAttendanceUseCase useCase;
  final InternetConnectionChecker internetChecker;
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;

  AttendanceBloc(this.useCase, this.internetChecker) : super(const Initial()) {
    on<MarkAttendance>(_handleMarkAttendance);
    on<LoadAttendanceList>(_handleLoadAttendanceList);

    _connectionSubscription = internetChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        add(LoadAttendanceList());
      }
    });
  }

  Future<void> _handleMarkAttendance(
    MarkAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const Loading());

    try {
      final permission = await _checkLocationPermission();
      if (!permission) {
        emit(const Failure("Location permission denied"));
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      const allowedLat = 10.8505;
      const allowedLng = 76.2711;
      const radiusInMeters = 80000;

      final distance = Geolocator.distanceBetween(
        allowedLat,
        allowedLng,
        position.latitude,
        position.longitude,
      );

      if (distance > radiusInMeters) {
        emit(const Failure("You are not in the allowed location."));
        return;
      }

      final entity = AttendanceEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
      );

      await useCase.saveLocally(entity);

      final isOnline = await internetChecker.hasConnection;
      if (isOnline) {
        await useCase.syncToServer(entity);
      }

      emit(const Success());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _handleLoadAttendanceList(
    LoadAttendanceList event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const Loading());
    try {
      final isOnline = await internetChecker.hasConnection;
      if (isOnline) {
        await useCase.repository.syncUnsynced();
        await useCase.repository.cleanUpLocalStorage();
        final remoteData = await useCase.repository.getRemote();
        await useCase.repository.cacheLocally(remoteData);
        emit(AttendanceState.attendanceLoaded(remoteData));
      } else {
        final localData = await useCase.repository.getLocal();
        emit(AttendanceState.attendanceLoaded(localData));
      }
    } catch (e) {
      emit(AttendanceState.failure(e.toString()));
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}
