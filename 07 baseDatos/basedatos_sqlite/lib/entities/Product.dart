class Product {
  final int? id; // conviene permitir null al crear antes de insertar
  final String name;
  final double price;
  final String description;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  Product copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }

  /// Constructor nombrado para crear desde un mapa
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
    );
  }

  /// Método estático para lista
  static List<Product> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Product.fromMap(map)).toList();
  }
}
