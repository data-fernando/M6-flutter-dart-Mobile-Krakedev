import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mecanico.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mecanicos(
        cedula TEXT PRIMARY KEY,
        nombre TEXT NOT NULL,
        especialidad TEXT NOT NULL,
        disponibilidad INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE vehiculos(
        placa TEXT PRIMARY KEY,
        modelo TEXT NOT NULL,
        marca TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ordenes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fk_vehiculo TEXT NOT NULL,
        fk_mecanico TEXT NOT NULL,
        estado TEXT NOT NULL,
        descripcion TEXT NOT NULL,
        fecha_ingreso TEXT NOT NULL,
        fecha_entrega TEXT,
        precio REAL NOT NULL DEFAULT 0.0,
        FOREIGN KEY (fk_vehiculo) REFERENCES vehiculos(placa),
        FOREIGN KEY (fk_mecanico) REFERENCES mecanicos(cedula)
      )
    ''');
  }
}
