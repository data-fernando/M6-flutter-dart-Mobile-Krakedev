class Jugador{
  static const String nombrejuego="aventura epica";
  final int id;
  late String nombre;
  var puntuacion;
  dynamic extra;

  Jugador(this.id);

}


void main(){


  final jugador = Jugador(1);


  jugador.nombre = "Fernando";
  jugador.puntuacion = 100;
  jugador.extra = 100;

  print(jugador.id);
  print(jugador.nombre);
  print(jugador.puntuacion);
  print(jugador.extra);

  print(Jugador.nombrejuego);
}