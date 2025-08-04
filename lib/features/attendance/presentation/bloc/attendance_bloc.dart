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

  AttendanceBloc(this.useCase, this.internetChecker) : super(const Initial()) {
    on<MarkAttendance>(_onMarkAttendance);
    on<LoadAttendanceList>(_onLoadAttendanceList);
  }

  Future<void> _onMarkAttendance(
    MarkAttendance event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const Loading());

    try {
      // ✅ Location permission checks
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const Failure("Location permission denied"));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(const Failure(
          "Location permissions are permanently denied. Please enable them in settings.",
        ));
        return;
      }

      // ✅ Location validation
      final position = await Geolocator.getCurrentPosition();
      const double allowedLat = 10.8505;
      const double allowedLng = 76.2711;
      const double radiusInMeters = 80000;

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

      // ✅ Create entity
      final entity = AttendanceEntity(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
      );

      // ✅ Always save locally
      await useCase.saveLocally(entity);

      // ✅ Sync if online
      final isOnline = await internetChecker.hasConnection;
      if (isOnline) {
        await useCase.syncToServer(entity);
      }

      emit(const Success());
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }

  Future<void> _onLoadAttendanceList(
    LoadAttendanceList event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(const Loading());

    try {
      final isOnline = await internetChecker.hasConnection;

      if (isOnline) {
        // ✅ Sync unsynced
        await useCase.repository.syncUnsynced();

        // ✅ Get remote data
        final remote = await useCase.repository.getRemote();

        // ✅ Optional: cache it locally
        await useCase.repository.cacheLocally(remote);

        emit(AttendanceState.attendanceLoaded(remote));
      } else {
        // ✅ Fallback to local
        final local = await useCase.repository.getLocal();
        emit(AttendanceState.attendanceLoaded(local));
      }
    } catch (e) {
      emit(AttendanceState.failure(e.toString()));
    }
  }
}
