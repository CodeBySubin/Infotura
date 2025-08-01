import 'package:infotura/features/attendance/domain/attendancy_enity.dart';

abstract class AttendanceRepository {
  Future<void> saveLocally(AttendanceEntity entity);
  Future<void> syncToServer(AttendanceEntity entity);
  Future<void> syncUnsynced();
  Future<List<AttendanceEntity>> getLocal();
  Future<List<AttendanceEntity>> getRemote();
  Future<void> cacheLocally(List<AttendanceEntity> entities);
}

