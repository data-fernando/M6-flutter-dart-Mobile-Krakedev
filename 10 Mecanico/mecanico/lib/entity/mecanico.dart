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
