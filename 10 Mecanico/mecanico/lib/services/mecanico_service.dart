import 'package:sqflite/sqflite.dart';
import '../entity/mecanico.dart';
import 'dbhelper.dart';

class MecanicoService {
  final DBHelper _dbHelper = DBHelper();

  Future<void> insertarMecanico(Mecanico mecanico) async {
    final db = await _dbHelper.database;
    await db.insert('mecanicos', mecanico.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> actualizarMecanico(Mecanico mecanico) async {
    final db = await _dbHelper.database;
    await db.update('mecanicos', mecanico.toMap(),
        where: 'cedula = ?', whereArgs: [mecanico.cedula]);
  }

  Future<void> eliminarMecanico(String cedula) async {
    final db = await _dbHelper.database;
    await db.delete('mecanicos', where: 'cedula = ?', whereArgs: [cedula]);
  }

  Future<List<Mecanico>> obtenerTodosLosMecanicos() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('mecanicos');
    return maps.map((map) => Mecanico.fromMap(map)).toList();
  }

  Future<List<Mecanico>> obtenerMecanicosDisponibles() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('mecanicos', where: 'disponibilidad = 1');
    return maps.map((map) => Mecanico.fromMap(map)).toList();
  }

  Future<Mecanico?> obtenerMecanicoPorCedula(String cedula) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('mecanicos', where: 'cedula = ?', whereArgs: [cedula]);
    if (maps.isEmpty) return null;
    return Mecanico.fromMap(maps.first);
  }

  Future<void> actualizarDisponibilidad(String cedula, bool disponible) async {
    final db = await _dbHelper.database;
    await db.update(
      'mecanicos',
      {'disponibilidad': disponible ? 1 : 0},
      where: 'cedula = ?',
      whereArgs: [cedula],
    );
  }
}
