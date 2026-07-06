class Producto{
    String codigo;
    String? descripcion;
    double precio;
    
    Producto(this.codigo,this.precio,[this.descripcion]);

    Producto.oferta(this.codigo,this.precio):this.descripcion="producto constructor nombrado";

    @override
    String toString() {
      // TODO: implement toString
      return "Codigo: $codigo, Descripcion: $descripcion, Precio: $precio";
    }

}


void main() {
  var producto1 = Producto("123", 10.0);
  var producto2 = Producto("456", 20.0,"Producto 2");
  var producto3 = Producto.oferta("789",7.0);

  print(producto1);
  print(producto2);
  print(producto3);

}