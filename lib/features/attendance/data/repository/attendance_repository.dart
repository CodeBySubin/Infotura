

import 'package:infotura/features/attendance/data/model/attendance_model.dart';
import 'package:infotura/features/attendance/data/datasource/attendance_local_datasourece.dart';
import 'package:infotura/features/attendance/data/datasource/attendance_remote_datasource.dart';
import 'package:infotura/features/attendance/domain/repository/attendance_repository.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';


class AttendanceRepositoryImpl implements AttendanceRepository {
  final LocalAttendanceDataSource local;
  final AttendanceRemoteDataSource remote;

  AttendanceRepositoryImpl(this.local, this.remote);

  Future<void> markAttendance(AttendanceEntity entity, bool isOnline) async {
    final model = AttendanceModel.fromEntity(entity);
    await local.save(model);
    if (isOnline) {
      await remote.send(model);
      await local.markAsSynced(model);
    }
  }

  // ✅ Always called
  @override
  Future<void> saveLocally(AttendanceEntity entity) async {
    final model = AttendanceModel.fromEntity(entity);
    await local.save(model);
  }

  // ✅ Called only when internet is available
  @override
  Future<void> syncToServer(AttendanceEntity entity) async {
    final model = AttendanceModel.fromEntity(entity);
    await remote.send(model);
    await local.markAsSynced(model);
  }

  // ✅ Used to sync all unsynced entries
  @override
  Future<void> syncUnsynced() async {
    final unsynced = await local.getUnsynced();
    for (var model in unsynced) {
      await remote.send(model);
      await local.markAsSynced(model);
    }
  }

  // ✅ Load remote data
  @override
  Future<List<AttendanceEntity>> getRemote() async {
    final remoteData = await remote.fetchAll();
    return remoteData.map((e) => e.toEntity()).toList();
  }

  // ✅ Load local data
  @override
  Future<List<AttendanceEntity>> getLocal() async {
    final localData = await local.getAll();
    return localData.map((e) => e.toEntity()).toList();
  }

  // ✅ Optional: Cache remote data locally
  @override
  Future<void> cacheLocally(List<AttendanceEntity> entities) async {
    for (var entity in entities) {
      final model = AttendanceModel.fromEntity(entity);
      await local.save(model);
      await local.markAsSynced(model);
    }
  }
}
