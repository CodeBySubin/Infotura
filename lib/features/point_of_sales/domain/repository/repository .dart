import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';
import 'package:infotura/features/point_of_sales/domain/entity/pof_entity.dart';

abstract class BillRepository {
  Future<void> saveBillLocally(BillEntity entity);
  Future<void> syncBillToServer(BillEntity entity);
  Future<void> syncUnsyncedBills();
  List<BillModel> getUnsyncedLocalBills();
  Future<List<BillEntity>> getLocalBills();
  Future<List<BillEntity>> getRemoteBills();
  Future<void> cacheBillsLocally(List<BillEntity> bills);
    Future<void> cleanUpLocalStorage(List<String> remoteIds);

}