

import 'package:infotura/features/point_of_sales/data/datasource/firebase_datasource.dart';
import 'package:infotura/features/point_of_sales/data/datasource/hive_datasource.dart';
import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';
import 'package:infotura/features/point_of_sales/domain/entity/pof_entity.dart';
import 'package:infotura/features/point_of_sales/domain/repository/repository%20.dart';

class BillRepositoryImpl implements BillRepository {
  final LocalBillDataSource local;
  final RemoteBillDataSource remote;

  BillRepositoryImpl(this.local, this.remote);

  @override
  Future<void> saveBillLocally(BillEntity entity) async {
    await local.saveBill(BillModel.fromEntity(entity));
  }

  @override
  Future<void> syncBillToServer(BillEntity entity) async {
    final model = BillModel.fromEntity(entity);
    await remote.syncBill(model);
    await local.markAsSynced(model.id);
  }

  @override
  Future<void> syncUnsyncedBills() async {
    final unsynced = local.getUnsyncedBills();
    for (final bill in unsynced) {
      await remote.syncBill(bill);
      await local.markAsSynced(bill.id);
    }
  }

  @override
  List<BillModel> getUnsyncedLocalBills() => local.getUnsyncedBills();

  @override
  Future<List<BillEntity>> getLocalBills() async {
    return local.getAll().map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<BillEntity>> getRemoteBills() async {
    final remoteModels = await remote.fetchAll();
    return remoteModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> cacheBillsLocally(List<BillEntity> bills) async {
    for (var bill in bills) {
      final model = BillModel.fromEntity(bill);
      await local.saveBill(model);
      await local.markAsSynced(model.id);
    }
  }
  
@override
Future<void> cleanUpLocalStorage(List<String> remoteIds) async {
  final allLocal = local.getAll();
  for (final bill in allLocal) {
    if (!remoteIds.contains(bill.id)) {
      await bill.delete(); 
    }
  }
}

}
