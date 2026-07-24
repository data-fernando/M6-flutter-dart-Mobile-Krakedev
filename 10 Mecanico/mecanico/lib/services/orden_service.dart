import '../entity/orden.dart';
import 'dbhelper.dart';

class OrdenService {
  final DBHelper _dbHelper = DBHelper();

  Future<void> insertarOrden(Orden orden) async {
    final db = await _dbHelper.database;
    final map = orden.toMap();
    map.remove('id');
    await db.insert('ordenes', map);
  }

  Future<void> actualizarOrden(Orden orden) async {
    final db = await _dbHelper.database;
    await db.update('ordenes', orden.toMap(),
        where: 'id = ?', whereArgs: [orden.id]);
  }

  Future<void> eliminarOrden(int id) async {
    final db = await _dbHelper.database;
    await db.delete('ordenes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Orden>> obtenerTodasLasOrdenes() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('ordenes');
    return maps.map((map) => Orden.fromMap(map)).toList();
  }

  Future<Orden?> obtenerOrdenPorId(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('ordenes', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Orden.fromMap(maps.first);
  }

  Future<List<Orden>> obtenerOrdenesPorEstado(String estado) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('ordenes', where: 'estado = ?', whereArgs: [estado]);
    return maps.map((map) => Orden.fromMap(map)).toList();
  }
}
