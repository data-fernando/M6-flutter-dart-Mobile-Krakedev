import 'package:sqflite/sqflite.dart';

import '../entity/vehiculo.dart';
import 'dbhelper.dart';

class VehiculoService {
  final DBHelper _dbHelper = DBHelper();

  Future<void> insertarVehiculo(Vehiculo vehiculo) async {
    final db = await _dbHelper.database;
    await db.insert('vehiculos', vehiculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> actualizarVehiculo(Vehiculo vehiculo) async {
    final db = await _dbHelper.database;
    await db.update('vehiculos', vehiculo.toMap(),
        where: 'placa = ?', whereArgs: [vehiculo.placa]);
  }

  Future<void> eliminarVehiculo(String placa) async {
    final db = await _dbHelper.database;
    await db.delete('vehiculos', where: 'placa = ?', whereArgs: [placa]);
  }

  Future<List<Vehiculo>> obtenerTodosLosVehiculos() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('vehiculos');
    return maps.map((map) => Vehiculo.fromMap(map)).toList();
  }

  Future<Vehiculo?> obtenerVehiculoPorPlaca(String placa) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps =
        await db.query('vehiculos', where: 'placa = ?', whereArgs: [placa]);
    if (maps.isEmpty) return null;
    return Vehiculo.fromMap(maps.first);
  }
}
