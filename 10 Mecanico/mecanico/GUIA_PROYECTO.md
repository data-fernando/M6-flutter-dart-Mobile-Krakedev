# Taller Mecanico - Flutter + SQLite

Sistema de gestion de taller mecanico con almacenamiento local using SQLite.

## Entidades

- **Mecanico**: cedula (PK), nombre, especialidad, disponibilidad (bool)
- **Vehiculo**: placa (PK), modelo, marca
- **Orden**: id (PK autoincrement), fk_vehiculo (FK), fk_mecanico (FK), estado, descripcion, fecha_ingreso, fecha_entrega, precio (calculado)

## Funcionalidades

- CRUD completo para Mecanicos, Vehiculos y Ordenes
- Calculo automatico de precio en Orden basado en especialidad y horas de trabajo
- Filtrado de mecanicos por disponibilidad al crear una orden
- Toggle de disponibilidad de mecanicos
- Estados de orden: Pendiente, En Proceso, Completada, Cancelada

## Pasos para crear el proyecto manualmente

### Paso 1: Crear el proyecto Flutter

```bash
flutter create mecanico
cd mecanico
```

### Paso 2: Configurar pubspec.yaml

Reemplazar el contenido de `pubspec.yaml` con:

```yaml
name: mecanico
description: "Sistema de gestion de taller mecanico"
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: ^3.12.2

dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.2
  path: ^1.9.1
  intl: ^0.20.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
```

### Paso 3: Instalar dependencias

```bash
flutter pub get
```

### Paso 4: Crear estructura de carpetas

```bash
mkdir -p lib/entity lib/services lib/views lib/widgets
```

### Paso 5: Crear las entidades (modelos)

Crear `lib/entity/mecanico.dart`:

```dart
class Mecanico {
  final String? cedula;
  final String nombre;
  final String especialidad;
  final bool disponibilidad;

  Mecanico({
    this.cedula,
    required this.nombre,
    required this.especialidad,
    this.disponibilidad = true,
  });

  Map<String, dynamic> toMap() => {
    'cedula': cedula,
    'nombre': nombre,
    'especialidad': especialidad,
    'disponibilidad': disponibilidad ? 1 : 0,
  };

  factory Mecanico.fromMap(Map<String, dynamic> map) => Mecanico(
    cedula: map['cedula']?.toString(),
    nombre: map['nombre'] ?? '',
    especialidad: map['especialidad'] ?? '',
    disponibilidad: (map['disponibilidad'] ?? 1) == 1,
  );

  Mecanico copyWith({
    String? cedula,
    String? nombre,
    String? especialidad,
    bool? disponibilidad,
  }) {
    return Mecanico(
      cedula: cedula ?? this.cedula,
      nombre: nombre ?? this.nombre,
      especialidad: especialidad ?? this.especialidad,
      disponibilidad: disponibilidad ?? this.disponibilidad,
    );
  }
}
```

Crear `lib/entity/vehiculo.dart`:

```dart
class Vehiculo {
  final String? placa;
  final String modelo;
  final String marca;

  Vehiculo({
    this.placa,
    required this.modelo,
    required this.marca,
  });

  Map<String, dynamic> toMap() => {
    'placa': placa,
    'modelo': modelo,
    'marca': marca,
  };

  factory Vehiculo.fromMap(Map<String, dynamic> map) => Vehiculo(
    placa: map['placa']?.toString(),
    modelo: map['modelo'] ?? '',
    marca: map['marca'] ?? '',
  );

  Vehiculo copyWith({
    String? placa,
    String? modelo,
    String? marca,
  }) {
    return Vehiculo(
      placa: placa ?? this.placa,
      modelo: modelo ?? this.modelo,
      marca: marca ?? this.marca,
    );
  }
}
```

Crear `lib/entity/orden.dart`:

```dart
class Orden {
  final int? id;
  final String fkVehiculo;
  final String fkMecanico;
  final String estado;
  final String descripcion;
  final DateTime fechaIngreso;
  final DateTime? fechaEntrega;
  final double precio;

  Orden({
    this.id,
    required this.fkVehiculo,
    required this.fkMecanico,
    required this.estado,
    required this.descripcion,
    required this.fechaIngreso,
    this.fechaEntrega,
    this.precio = 0.0,
  });

  static double calcularPrecio({
    required String especialidad,
    required DateTime fechaIngreso,
    required DateTime? fechaEntrega,
  }) {
    const Map<String, double> tarifas = {
      'Mecanico General': 25.0,
      'Electricista': 35.0,
      'Latonero': 30.0,
      'Pintor': 28.0,
      'Soldador': 32.0,
      'Diesel': 40.0,
    };

    final tarifa = tarifas[especialidad] ?? 30.0;
    final fechaFin = fechaEntrega ?? DateTime.now();
    final duracion = fechaFin.difference(fechaIngreso);
    final horas = duracion.inHours.toDouble().clamp(1.0, double.infinity);

    return tarifa * horas;
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'fk_vehiculo': fkVehiculo,
    'fk_mecanico': fkMecanico,
    'estado': estado,
    'descripcion': descripcion,
    'fecha_ingreso': fechaIngreso.toIso8601String(),
    'fecha_entrega': fechaEntrega?.toIso8601String(),
    'precio': precio,
  };

  factory Orden.fromMap(Map<String, dynamic> map) => Orden(
    id: map['id'] as int?,
    fkVehiculo: map['fk_vehiculo'] ?? '',
    fkMecanico: map['fk_mecanico'] ?? '',
    estado: map['estado'] ?? '',
    descripcion: map['descripcion'] ?? '',
    fechaIngreso: DateTime.parse(map['fecha_ingreso']),
    fechaEntrega: map['fecha_entrega'] != null
        ? DateTime.parse(map['fecha_entrega'])
        : null,
    precio: (map['precio'] ?? 0.0).toDouble(),
  );

  Orden copyWith({
    int? id,
    String? fkVehiculo,
    String? fkMecanico,
    String? estado,
    String? descripcion,
    DateTime? fechaIngreso,
    DateTime? fechaEntrega,
    double? precio,
  }) {
    return Orden(
      id: id ?? this.id,
      fkVehiculo: fkVehiculo ?? this.fkVehiculo,
      fkMecanico: fkMecanico ?? this.fkMecanico,
      estado: estado ?? this.estado,
      descripcion: descripcion ?? this.descripcion,
      fechaIngreso: fechaIngreso ?? this.fechaIngreso,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
      precio: precio ?? this.precio,
    );
  }
}
```

### Paso 6: Crear el servicio de base de datos

Crear `lib/services/dbhelper.dart`:

```dart
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
```

### Paso 7: Crear los servicios CRUD

Crear `lib/services/mecanico_service.dart`:

```dart
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
```

Crear `lib/services/vehiculo_service.dart`:

```dart
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
```

Crear `lib/services/orden_service.dart`:

```dart
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
```

### Paso 8: Crear las vistas (pantallas)

Crear `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taller Mecanico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
```

Crear `lib/views/home_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'mecanicos_page.dart';
import 'vehiculos_page.dart';
import 'ordenes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Taller Mecanico'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Mecanicos'),
              Tab(icon: Icon(Icons.directions_car), text: 'Vehiculos'),
              Tab(icon: Icon(Icons.build), text: 'Ordenes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MecanicosPage(),
            VehiculosPage(),
            OrdenesPage(),
          ],
        ),
      ),
    );
  }
}
```

Crear `lib/views/mecanicos_page.dart`, `lib/views/mecanico_form.dart`, `lib/views/mecanico_edit_form.dart`:

*(Ver archivos completos en el proyecto)*

Crear `lib/views/vehiculos_page.dart`, `lib/views/vehiculo_form.dart`, `lib/views/vehiculo_edit_form.dart`:

*(Ver archivos completos en el proyecto)*

Crear `lib/views/ordenes_page.dart`, `lib/views/orden_form.dart`, `lib/views/orden_edit_form.dart`:

*(Ver archivos completos en el proyecto)*

### Paso 9: Ejecutar el proyecto

```bash
flutter run
```

## Calculo de Precio

El precio se calcula automaticamente en `Orden.calcularPrecio()` basado en:

| Especialidad   | Tarifa/hora |
|----------------|-------------|
| Mecanico General | $25.00    |
| Electricista   | $35.00      |
| Latonero       | $30.00      |
| Pintor         | $28.00      |
| Soldador       | $32.00      |
| Diesel         | $40.00      |

Formula: `precio = tarifa_especialidad * horas_trabajadas`

Las horas se calculan entre `fechaIngreso` y `fechaEntrega` (o la fecha actual si no hay entrega definida).

## Logica de Disponibilidad

1. Al crear una orden, solo se muestran mecanicos con `disponibilidad = true`
2. Al asignar un mecanico a una orden, su disponibilidad se cambia a `false`
3. Se puede togglear la disponibilidad desde la pantalla de mecanicos con el Switch

## Estructura del Proyecto

```
lib/
├── main.dart
├── entity/
│   ├── mecanico.dart
│   ├── vehiculo.dart
│   └── orden.dart
├── services/
│   ├── dbhelper.dart
│   ├── mecanico_service.dart
│   ├── vehiculo_service.dart
│   └── orden_service.dart
└── views/
    ├── home_page.dart
    ├── mecanicos_page.dart
    ├── mecanico_form.dart
    ├── mecanico_edit_form.dart
    ├── vehiculos_page.dart
    ├── vehiculo_form.dart
    ├── vehiculo_edit_form.dart
    ├── ordenes_page.dart
    ├── orden_form.dart
    └── orden_edit_form.dart
```
