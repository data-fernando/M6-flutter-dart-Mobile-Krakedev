import 'package:basedatos_sqlite/entities/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        description TEXT
      )
      ''');
  }

  Future<Product> createProduct(Product product) async {
    final db = await instance.database;
    final id = await db.insert('products', product.toMap());
    print("se inserto el producto ${product.toMap()} al parecer");
    return product.copyWith(id: id);
  }

  Future<Product> getProduct(int id) async {
    final db = await instance.database;
    final result = await db.query('products', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      print('se encontro el producto ${Product.fromMap(result.first).toMap()}');
      return Product.fromMap(result.first);
    }
    throw Exception('Product not found');
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return Product.fromList(result);
  }

  Future<Product> updateProduct(Product product) async {
    final db = await instance.database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
    print('se actualizo el producto ${product.toMap()} al parecer');
    return product; // devolvemos el mismo objeto
  }

Future<bool> deleteProduct(int id) async {
  final db = await instance.database;
  final count = await db.delete('products', where: 'id = ?', whereArgs: [id]);

  if (count > 0) {
    print('Se eliminó el producto con id $id');
    return true;
  } else {
    print('No se encontró producto con id $id');
    return false;
  }
}

}
