class AttendanceEntity {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  bool isSynced;

  AttendanceEntity({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.isSynced = false,
  });
}
