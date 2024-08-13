import 'package:paloma_test_app/src/feature/product/model/product_model.dart';

enum OrderStatus {
  paid,
  unPaid,
}

class OrderModel {
  final int id;
  final String guestName;
  final int tableNumber;
  final DateTime finishedAt;
  final double totalAmount;
  final int questCount;
  final List<ProductModel>? products;
  final OrderStatus orderStatus;

  OrderModel({
    required this.id,
    required this.guestName,
    required this.tableNumber,
    required this.finishedAt,
    required this.totalAmount,
    required this.questCount,
    required this.orderStatus,
    this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'guestName': guestName,
      'tableNumber': tableNumber,
      'finishedAt': finishedAt.millisecondsSinceEpoch,
      'totalAmount': totalAmount,
      'questCount': questCount,
      'orderStatus': orderStatus.index, // Store enum as integer
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map, List<ProductModel> products) {
    return OrderModel(
      id: map['id'],
      guestName: map['guestName'],
      tableNumber: map['tableNumber'],
      finishedAt: DateTime.fromMillisecondsSinceEpoch(map['finishedAt']),
      totalAmount: map['totalAmount'],
      questCount: map['questCount'],
      products: products,
      orderStatus: OrderStatus.values[map['orderStatus']], // Convert integer to enum
    );
  }
}
