import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendancy_enity.freezed.dart';
part 'attendancy_enity.g.dart';



@freezed
class AttendanceEntity with _$AttendanceEntity {
  const factory AttendanceEntity({
    required double latitude,
    required double longitude,
    required DateTime timestamp,
    @Default(false) bool isSynced,
  }) = _AttendanceEntity;


  factory AttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEntityFromJson(json);
}
