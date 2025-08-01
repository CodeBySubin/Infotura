import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.freezed.dart';

@freezed
class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent.markAttendance() = MarkAttendance;
  const factory AttendanceEvent.loadAttendanceList() = LoadAttendanceList;

}