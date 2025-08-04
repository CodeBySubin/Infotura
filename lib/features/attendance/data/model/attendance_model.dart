import 'package:hive/hive.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';

part 'attendance_model.g.dart';


@HiveType(typeId: 1)
class AttendanceModel extends HiveObject {
  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  @HiveField(2)
  DateTime timestamp;

  @HiveField(3)
  bool synced; 

  AttendanceModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.synced = false,
  });

  factory AttendanceModel.fromEntity(AttendanceEntity entity) {
    return AttendanceModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
      timestamp: entity.timestamp,
      synced: entity.isSynced,
    );
  }

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,
      isSynced: synced,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'synced': synced,
    };
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
      synced: json['synced'] ?? false,
    );
  }
}
