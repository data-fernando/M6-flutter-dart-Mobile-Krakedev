class calculadora{
  int sumar(int a, int b){
    return a+b;
  }
}

void main(){
  final calc=calculadora();
  var respuesta=calc.sumar(5, 4);
  print(respuesta);
}