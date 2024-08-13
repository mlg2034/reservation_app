import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'restaurant.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
       await db.execute('''
      CREATE TABLE tables (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tableNumber INTEGER NOT NULL,
        waiter TEXT,
        acceptedAt INTEGER,
        status INTEGER NOT NULL,
        maxSeats INTEGER NOT NULL,
        seatsOccupied INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        cost REAL NOT NULL
      )
    ''');

     await db.execute('''
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      guestName TEXT NOT NULL,
      tableNumber INTEGER NOT NULL,
      finishedAt INTEGER NOT NULL,
      totalAmount REAL NOT NULL,
      questCount INTEGER NOT NULL,
      orderStatus INTEGER NOT NULL
    )
  ''');

    await db.execute('''
      CREATE TABLE order_products (
        orderId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        FOREIGN KEY (orderId) REFERENCES orders(id) ON DELETE CASCADE,
        FOREIGN KEY (productId) REFERENCES products(id) ON DELETE CASCADE,
        PRIMARY KEY (orderId, productId)
      )
    ''');
  }

}
