//FUNCION MAIN

// void main(){
//   print("mi primera vez con dart");
// }

// TIPOS DE DATOS

// void main(){
//   String nombre="Fernando";
//   bool esAlto=true;
//   int edad=28;
//   double altura=1.78;

//   print(nombre);
//   print(esAlto);
//   print(edad);
//   print(altura);

// }




// Variable "var", no tienes que decir que tipo de dato es. y define 
// .runtimeType

void main() {
  var nombre = "Fernando";   // tipo inferido: String
  var edad = 30;              // tipo inferido: int

  print(nombre.runtimeType);  // imprime: String
  print(edad.runtimeType);    // imprime: int
}
