class Tienda {
  static String nombre = 'Supermercado Central';
  static List<Producto> productos = [];
  static List<Producto> _productosVendidos = [];

  static void cambiarNombre(String nuevo) {
    nombre = nuevo;
  }

  static void registrarVenta(Producto p) {
    _productosVendidos.add(p);
  }

  static int obtenerTotal() {
    return _productosVendidos.length;
  }

  static void mostrarValores() {
    print('Tienda: $nombre');
    print('Productos vendidos: ${_productosVendidos.length}');
  }
}

class Producto {
  final String codigo;
  late String descripcion;
  late double precio;
  dynamic observacion;

  Producto(this.codigo);

  void registrarVenta(String desc, double nuevoPrecio, dynamic obs) {
    descripcion = desc;
    precio = nuevoPrecio;
    observacion = obs;
    Tienda.registrarVenta(this);
  }

  void resumen() {
    print('Producto: $codigo, Desc: $descripcion, Precio: $precio, Obs: $observacion');
    print('Tienda: ${Tienda.nombre}');
  }
}

void main() {
  var p1 = Producto('001');
  p1.registrarVenta('Leche entera', 1.50, 'Promoción 2x1');

  var p2 = Producto('002');
  p2.registrarVenta('Pan integral', 2.00, 'Fresco del día');

  Tienda.cambiarNombre('Supermercado San Juan');

  p1.resumen();
  p2.resumen();

  Tienda.mostrarValores();
  print('Total vendidos: ${Tienda.obtenerTotal()}');
}
