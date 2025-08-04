import 'package:hive/hive.dart';
import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';

class LocalBillDataSource {
  final Box<BillModel> box;

  LocalBillDataSource(this.box);

  Future<void> saveBill(BillModel model) async {
    await box.put(model.id, model);
  }

  List<BillModel> getAll() => box.values.toList();

  List<BillModel> getUnsyncedBills() =>
      box.values.where((bill) => bill.synced == false).toList();

  Future<void> markAsSynced(String id) async {
    final bill = box.get(id);
    if (bill != null) {
      bill.synced = true;
      await bill.save();
    }
  }
}