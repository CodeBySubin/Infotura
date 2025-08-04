import 'package:infotura/features/attendance/domain/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';

class MarkAttendanceUseCase {
  final AttendanceRepository repository;
  MarkAttendanceUseCase(this.repository);
  Future<void> call(AttendanceEntity entity, bool isOnline) async {
    await saveLocally(entity);
    if (isOnline) {
      await syncToServer(entity);
    }
  }

  Future<void> saveLocally(AttendanceEntity entity) {
    return repository.saveLocally(entity);
  }

  Future<void> syncToServer(AttendanceEntity entity) {
    return repository.syncToServer(entity);
  }

  
}
