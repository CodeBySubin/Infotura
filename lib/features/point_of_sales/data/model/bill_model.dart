import 'package:hive/hive.dart';
import 'package:infotura/features/point_of_sales/domain/entity/pof_entity.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 0)
class BillModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productName;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  double price;

  @HiveField(4)
  DateTime dateTime;

  @HiveField(5)
  bool synced;

  BillModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.dateTime,
    this.synced = false,
  });

  BillEntity toEntity() => BillEntity(
        id: id,
        productName: productName,
        quantity: quantity,
        price: price,
        dateTime: dateTime,
      );

  factory BillModel.fromEntity(BillEntity entity) => BillModel(
        id: entity.id,
        productName: entity.productName,
        quantity: entity.quantity,
        price: entity.price,
        dateTime: entity.dateTime,
        synced: false,
      );
}
