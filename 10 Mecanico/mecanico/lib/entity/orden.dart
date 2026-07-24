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
