// void main() {
//   print("hola");
//   Future.delayed(Duration(seconds: 3), () => print("programacion asincrona"));
//   print("hola2");

//   hacerPedido();
  
// }

Future<String> prepararPedido(){
  return Future.delayed(Duration(seconds: 5),()=> "pedido listo");
}

void hacerPedido() async{
  print("haciendo pedido");
  String pedido = await prepararPedido();
  print(pedido);
  print("pedido recibido por el repartidor");

}


// void main(){
//   print("necesito comprar algo");
//   print("se lo que voy a comprar ");
//   hacerPedido();
//   print("espero el pedido");

// }

Future<String> esperarUber() {
  // Simula que el Uber tarda 3 segundos en llegar
  return Future.delayed(Duration(seconds: 3), () => "Uber ha llegado");
}

void pedirUber() async {
  print("Solicitando un Uber...");
  String llegada = await esperarUber();
  print(llegada);
  print("Subiendo al Uber y comenzando el viaje");
}

void main() {
  print("Necesito ir al centro");
  print("Abro la app de Uber");
  pedirUber();
  print("Mientras tanto, sigo esperando en la calle...");
}

