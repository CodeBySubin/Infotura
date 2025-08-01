import 'package:infotura/features/point_of_sales/data/datasource/firebase_datasource.dart';
import 'package:infotura/features/point_of_sales/data/datasource/hive_datasource.dart';
import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';
import 'package:infotura/features/point_of_sales/domain/pof_entity.dart';

class BillRepository {
  final LocalBillDataSource local;
  final RemoteBillDataSource remote;

  BillRepository(this.local, this.remote);

  // ✅ Always save locally
  Future<void> saveBillLocally(BillEntity entity) async {
    final model = BillModel.fromEntity(entity);
    await local.saveBill(model);
  }

  // ✅ Try syncing to server (called only if online)
  Future<void> syncBillToServer(BillEntity entity) async {
    final model = BillModel.fromEntity(entity);
    await remote.syncBill(model);
    await local.markAsSynced(model.id);
  }

  // ✅ Combined method, used in legacy AddBill logic
  Future<void> addBill(BillEntity entity, bool isOnline) async {
    await saveBillLocally(entity);
    if (isOnline) {
      await syncBillToServer(entity);
    }
  }

  // ✅ Sync any unsynced bills
  Future<void> syncUnsyncedBills() async {
    final unsynced = local.getUnsyncedBills();
    for (final bill in unsynced) {
      await remote.syncBill(bill);
      await local.markAsSynced(bill.id);
    }
  }

  // ✅ Local data only (used when offline)
  Future<List<BillEntity>> getLocalBills() async {
    return local.getAll().map((e) => e.toEntity()).toList();
  }

  // ✅ Remote data (used when online)
  Future<List<BillEntity>> getRemoteBills() async {
    final data = await remote.fetchAll();
    return data.map((e) => e.toEntity()).toList();
  }

  // ✅ Optional: cache remote bills to local (if needed)
  Future<void> cacheBillsLocally(List<BillEntity> bills) async {
    for (var bill in bills) {
      final model = BillModel.fromEntity(bill);
      await local.saveBill(model);
      await local.markAsSynced(model.id);
    }
  }
}
