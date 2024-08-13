import 'package:paloma_test_app/core/db/database_service';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';
import 'package:sqflite/sqflite.dart';

class TableRepository {
  final DatabaseService _databaseService;
  TableRepository(this._databaseService);

  Future<int> createTable(TableModel table) async {
    final db = await _databaseService.database;
    return await db.insert(
      'tables',
      table.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<TableModel> getTable(int id) async {
    final db = await _databaseService.database;
    final maps = await db.query(
      'tables',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return TableModel.fromMap(maps.first);
  }

  Future<List<TableModel>> getAllTables() async {
    final db = await _databaseService.database;
    final result = await db.query('tables');

    return result.map((map) => TableModel.fromMap(map)).toList();
  }

}
