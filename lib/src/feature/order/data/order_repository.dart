import 'package:paloma_test_app/core/db/database_service';
import 'package:paloma_test_app/src/feature/order/model/order_model.dart';
import 'package:paloma_test_app/src/feature/order/params/create_order_params.dart';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class OrderRepository {
  final DatabaseService _databaseService;

  OrderRepository(this._databaseService);
  Future<OrderModel> createOrder(CreateOrderParams params) async {
    final db = await _databaseService.database;

    final orderId = await db.insert(
      'orders',
      {
        'guestName': params.guestName,
        'tableNumber': params.tableNumber,
        'finishedAt': params.finishedAt.millisecondsSinceEpoch,
        'totalAmount': params.totalAmount,
        'questCount': params.questCount,
        'orderStatus': OrderStatus.paid.index,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (params.products != null) {
      for (final product in params.products!) {
        await db.insert('order_products', {
          'orderId': orderId,
          'productId': product.id,
        });
      }
    }

    return OrderModel(
      id: orderId,
      guestName: params.guestName,
      tableNumber: params.tableNumber,
      finishedAt: params.finishedAt,
      totalAmount: params.totalAmount,
      questCount: params.questCount,
      orderStatus: OrderStatus.paid,
      products: params.products,
    );
  }

  Future<OrderModel?> getOrder(int id) async {
    final db = await _databaseService.database;

    final orderMaps = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (orderMaps.isEmpty) return null;

    final productMaps = await db.rawQuery('''
      SELECT p.* FROM products p
      INNER JOIN order_products op ON p.id = op.productId
      WHERE op.orderId = ?
    ''', [id]);

    final products =
        productMaps.map((map) => ProductModel.fromMap(map)).toList();

    return OrderModel.fromMap(orderMaps.first, products);
  }

  Future<List<OrderModel>> getAllOrders() async {
    final db = await _databaseService.database;

    final orderMaps = await db.query('orders');
    final List<OrderModel> orders = [];

    for (var orderMap in orderMaps) {
      final productMaps = await db.rawQuery('''
        SELECT p.* FROM products p
        INNER JOIN order_products op ON p.id = op.productId
        WHERE op.orderId = ?
      ''', [orderMap['id']]);

      final products =
          productMaps.map((map) => ProductModel.fromMap(map)).toList();
      orders.add(OrderModel.fromMap(orderMap, products));
    }

    return orders;
  }

  Future<int> updateOrder(OrderModel order) async {
    final db = await _databaseService.database;

    final result = await db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );

    await db
        .delete('order_products', where: 'orderId = ?', whereArgs: [order.id]);

    if (order.products != null) {
      for (final product in order.products!) {
        await db.insert('order_products', {
          'orderId': order.id,
          'productId': product.id,
        });
      }
    }

    return result;
  }

  Future<int> deleteOrder(int id) async {
    final db = await _databaseService.database;

    await db.delete('order_products', where: 'orderId = ?', whereArgs: [id]);
    return await db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }
}
