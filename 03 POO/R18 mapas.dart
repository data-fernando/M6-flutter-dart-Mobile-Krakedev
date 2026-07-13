void main() {
  // 1. Mapa de jugadores y puntajes
  Map<String, int> puntajes = {
    'Carlos': 50,
    'Maria': 70,
    'Pedro': 40,
    'Ana': 90
  };

  // 2. Mostrar todos los nombres
  print('Jugadores: ${puntajes.keys}');

  // 3. Imprimir puntaje de un jugador específico
  print('Puntaje de Maria: ${puntajes['Maria']}');

  // 4. Modificar puntaje de un jugador
  puntajes['Carlos'] = 60;

  // 5. Agregar un nuevo jugador
  puntajes['Luis'] = 80;

  // 6. Eliminar un jugador
  puntajes.remove('Pedro');

  // 7. Imprimir mapa completo
  print('Mapa actualizado: $puntajes');
}
