import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infotura/features/point_of_sales/domain/pof_entity.dart';
part 'pos_event.freezed.dart';

@freezed
class PosEvent with _$PosEvent {
  const factory PosEvent.addBill(BillEntity bill) = AddBill;
  const factory PosEvent.loadSalesList() = LoadSalesList;
}
