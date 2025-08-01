import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotura/features/point_of_sales/domain/pof_entity.dart';
part 'pos_state.freezed.dart';

@freezed
class PosState with _$PosState {
  const factory PosState.initial() = Initial;
  const factory PosState.loading() = Loading;
  const factory PosState.loaded(List<BillEntity> sales) = Loaded;
  const factory PosState.error(String message) = Error;
}
