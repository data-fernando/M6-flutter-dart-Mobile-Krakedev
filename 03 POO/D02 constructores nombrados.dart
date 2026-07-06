class Coordenada{
    int x;
    int y;
    int? z;

    Coordenada(this.x,this.y,[this.z]);

    Coordenada.origen():this(0,2,3);

    @override
    String toString() {
      // TODO: implement toString
      return "Coordenada: ($x,$y,$z)";
    }


}

void main() {
  var coordenada1 = Coordenada(1,2);
  var coordenada2 = Coordenada(1,2,3);
  var coordenada3 = Coordenada.origen();
  print(coordenada1);
  print(coordenada2);
  print(coordenada3);
}



