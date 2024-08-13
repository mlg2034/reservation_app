import 'package:paloma_test_app/src/feature/product/model/product_model.dart';

class CreateOrderParams {
  final int tableNumber;

  final String guestName;
  final DateTime finishedAt;
  final double totalAmount;
  final int questCount;
  final List<ProductModel>? products;
  CreateOrderParams({
    required this.guestName,
    required this.tableNumber,
    required this.finishedAt,
    required this.totalAmount,
    required this.questCount,
    this.products,
  });
}
