// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/book.dart';

// class DataBaseHelper {
  
//   static final DataBaseHelper _instance = DataBaseHelper._internal();
//   factory DataBaseHelper() => _instance;
//   static Database? _database;

//   DataBaseHelper._internal();

// //Getter para la base de datos
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }
// //Función privada para inicializar la base de datos
//   Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), 'biblioteca.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

// //Función privada para crear la base de datos
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE books(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT,
//         author TEXT,
//         status TEXT,
//         note TEXT
//       )
//     ''');
//   }

//   Future<Book> getBookById(int id) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('books', where: 'id = ?', whereArgs: [id]);
//     if (maps.isEmpty) {
//       throw Exception('Book not found');
//     }
//     return Book(
//       id: maps[0]['id'],
//       title: maps[0]['title'],
//       author: maps[0]['author'],
//       status: maps[0]['status'],
//       note: maps[0]['note'],
//     );
//   }

//   Future<int> insertBook(Book book) async {
//     final db = await database;
//     return await db.insert('books', book.toMap());
//   }
//   Future<void> updateBook(Book book) async {
//     final db = await database;
//     await db.update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
//   }
//   Future<void> deleteBook(int id) async {
//     final db = await database;
//     await db.delete('books', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<List<Book>> getAllBooks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('books');
//     return List.generate(maps.length, (i) {
//       return Book(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         author: maps[i]['author'],
//         status: maps[i]['status'],
//         note: maps[i]['note'],
//       );
//     });
//   }

//   Future<int> countBooks() async {
//     final db = await database;
//     return await db.rawQuery('SELECT COUNT(*) FROM books').then((value) => value.first['COUNT(*)'] as int);
//   }


// }
