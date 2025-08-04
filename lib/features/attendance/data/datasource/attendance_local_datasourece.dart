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
    final key = model.timestamp.toIso8601String();
    final storedModel = box.get(key);
    if (storedModel != null) {
      storedModel.synced = true;
      await storedModel.save();
    }
  }

  Future<void> delete(String key) async {
    await box.delete(key);
  }

  Future<void> deleteAllExcept(List<String> validKeys) async {
    final keysToDelete = box.keys
        .where((key) => !validKeys.contains(key))
        .toList();
    await box.deleteAll(keysToDelete);
  }

  List<String> getAllKeys() {
    return box.keys.map((e) => e.toString()).toList();
  }
}
