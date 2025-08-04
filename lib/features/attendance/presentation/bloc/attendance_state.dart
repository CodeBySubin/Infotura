import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotura/features/attendance/domain/entity/attendancy_enity.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = Initial;
  const factory AttendanceState.loading() = Loading;
  const factory AttendanceState.success() = Success;
  const factory AttendanceState.failure(String message) = Failure;
  const factory AttendanceState.attendanceLoaded(List<AttendanceEntity> list) = AttendanceLoaded;

}
