import 'package:infotura/features/point_of_sales/data/model/bill_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RemoteBillDataSource {
  final FirebaseFirestore firestore;

  RemoteBillDataSource(this.firestore);

  Future<void> syncBill(BillModel model) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      // 🔕 No internet – skip Firestore sync
      return;
    }

    await firestore.collection('bills').doc(model.id).set({
      'productName': model.productName,
      'quantity': model.quantity,
      'price': model.price,
      'dateTime': model.dateTime.toIso8601String(),
    });
  }

  Future<List<BillModel>> fetchAll() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      // 🔕 No internet – return empty list to avoid crash
      return [];
    }

    final snapshot = await firestore.collection('bills').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return BillModel(
        id: doc.id,
        productName: data['productName'],
        quantity: data['quantity'],
        price: data['price'],
        dateTime: DateTime.parse(data['dateTime']),
      );
    }).toList();
  }
}
