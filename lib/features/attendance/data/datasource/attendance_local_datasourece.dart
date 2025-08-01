import 'package:hive/hive.dart';
import 'package:infotura/features/attendance/data/model/attendance_model.dart';
class LocalAttendanceDataSource {
  final Box<AttendanceModel> box;

  LocalAttendanceDataSource(this.box);

  Future<void> save(AttendanceModel model) async {
    await box.put(model.timestamp.toIso8601String(), model);
  }

  Future<List<AttendanceModel>> getAll() async {
    return box.values.toList();
  }

  Future<List<AttendanceModel>> getUnsynced() async {
    return box.values.where((e) => !e.synced).toList();
  }

  Future<void> markAsSynced(AttendanceModel model) async {
    model.synced = true;
    await model.save();
  }
}
