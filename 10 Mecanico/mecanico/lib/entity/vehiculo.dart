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
