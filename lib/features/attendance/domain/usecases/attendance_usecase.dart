
import 'package:infotura/features/attendance/domain/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';

import 'package:infotura/features/attendance/domain/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';

class MarkAttendanceUseCase {
  final AttendanceRepository repository;

  MarkAttendanceUseCase(this.repository);

  // ✅ Legacy compatibility
  Future<void> call(AttendanceEntity entity, bool isOnline) async {
    await saveLocally(entity);
    if (isOnline) {
      await syncToServer(entity);
    }
  }

  // ✅ Always save locally
  Future<void> saveLocally(AttendanceEntity entity) {
    return repository.saveLocally(entity);
  }

  // ✅ Only call this if internet is available
  Future<void> syncToServer(AttendanceEntity entity) {
    return repository.syncToServer(entity);
  }
}
