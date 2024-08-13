import 'package:paloma_test_app/core/db/database_service';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final DatabaseService _databaseService;

  ProductRepository(this._databaseService);
  Future<int> createProduct(ProductModel product) async {
    final db = await _databaseService.database;
    return await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await _databaseService.database;
    final result = await db.query('products');

    return result.map((map) => ProductModel.fromMap(map)).toList();
  }
}
