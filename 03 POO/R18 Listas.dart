void main() {
  // 1. Lista de comidas favoritas
  List<String> comidasFavoritas = ['Pizza', 'Hamburguesa', 'Ensalada', 'Sushi', 'Tacos'];

  // 2. Agregar una nueva comida
  comidasFavoritas.add('Lasagna');

  // 3. Eliminar una comida existente
  comidasFavoritas.remove('Ensalada');

  // 4. Imprimir la comida en la posición 2
  print('Comida en posición 2: ${comidasFavoritas[2]}');

  // 5. Lista de listas para menú semanal
  List<List<String>> menuSemanal = [
    ['Cereal', 'Pollo', 'Sopa'],       // Lunes
    ['Pan', 'Arroz con carne', 'Pizza'], // Martes
    ['Huevos', 'Pasta', 'Hamburguesa'], // Miércoles
    ['Fruta', 'Ensalada', 'Sushi'],     // Jueves
    ['Yogurt', 'Sandwich', 'Tacos'],    // Viernes
    ['Tostadas', 'Carne', 'Lasagna'],   // Sábado
    ['Café', 'Pescado', 'Arroz']        // Domingo
  ];

  // 6. Imprimir almuerzo del martes
  print('Almuerzo del martes: ${menuSemanal[1][1]}');

  // 7. Cambiar la cena del viernes
  menuSemanal[4][2] = 'Pizza';

  // 8. Recorrer menú semanal
  for (int i = 0; i < menuSemanal.length; i++) {
    print('Día ${i + 1}: ${menuSemanal[i]}');
  }
}
