class BillEntity {
  final String id;
  final String productName;
  final int quantity;
  final double price;
  final DateTime dateTime;

  BillEntity({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.dateTime,
  });
}