class Producto {
  String codigo = "";
  String nombre = "";
  String? descripcion;
  bool activo = true;
  double precio = 0;
  int? stock;
}

void main() {
  // new
  Producto p1 = new Producto();
  p1.codigo = "pr01";
  p1.nombre = "papas snacks";
  p1.descripcion = "rollos delgados de papa fritas";
  p1.precio = 0.99;
  p1.stock = 30;

  print("producto: ${p1.nombre} precio: ${p1.precio} stock: ${p1.stock}");

  //final (referencia fija)
  final p2 = Producto();
  p2.codigo = "pr02";
  p2.nombre = "chocolate bar";
  p2.descripcion = "barra de chocolate con leche";
  p2.precio = 1.50;
  p2.stock = 15;

  print("producto: ${p2.nombre} precio: ${p2.precio} stock: ${p2.stock}");

  // var (tipo inferido)
  var p3 = Producto();
  p3.codigo = "pr03";
  p3.nombre = "agua mineral";
  p3.descripcion = "botella de agua 500ml";
  p3.precio = 0.60;
  p3.stock = 50;

  print("producto: ${p3.nombre} precio: ${p3.precio} stock: ${p3.stock}");
}
