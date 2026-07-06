class Libro {
  String ISBN;
  String tipo;
  int? numeroPaginas;
  String? descripcion;


  Libro(this.ISBN,this.tipo,[this.numeroPaginas,this.descripcion]){
  

  }
  @override
  String toString() {
    // TODO: implement toString
    return "ISBN:$ISBN , Tipo: $tipo, Numero de paginas: $numeroPaginas, Descripcion: $descripcion";
  }

}

void main() {
  var libro1 = Libro("978-84-376-0417-2","Novela",224,"Una historia fascinante");
  var libro2 = Libro("978-84-376-0417-2","Novela",224,"Una historia fascinante");
  var libro3 = Libro("978-84-376-0417-2","Novela");
  
  print(libro1);
  print(libro2);
  print(libro3);
}
