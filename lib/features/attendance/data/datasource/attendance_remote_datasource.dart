import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infotura/features/attendance/data/model/attendance_model.dart';
class AttendanceRemoteDataSource {
  final FirebaseFirestore firestore;

  AttendanceRemoteDataSource(this.firestore);

  Future<void> send(AttendanceModel model) async {
    await firestore
        .collection("attendance")
        .doc(model.timestamp.toIso8601String())
        .set(model.toJson());
  }

  Future<List<AttendanceModel>> fetchAll() async {
    final snapshot = await firestore.collection('attendance').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return AttendanceModel(
        latitude: data['latitude'],
        longitude: data['longitude'],
        timestamp: DateTime.parse(data['timestamp']),
        synced: true,
      );
    }).toList();
  }

  Future<List<String>> fetchAllKeys() async {
    final snapshot = await firestore.collection('attendance').get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
}
