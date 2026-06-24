// con ? acepta null
//permite con un valor inical o especificar que es null con ?

class Persona{
  String? nombre;
  int edad=0;
  double? estatura;

}
//instancias objetos
// void main(){
//    Persona p=new Persona(); 
//    p.nombre="mario";
//    p.edad=41;
//    p.estatura=1.59;

//    //imprimir verialbels dentro de un string
//   print("Nombre: ${p.nombre} ");
//   print("edad: ${p.edad}");
// }



//instanciar objetos sin new 
// eituqeta final significa que no se puede reasignar la variable incluso si es del mismo tipo
void main(){
   final p=Persona(); 
   var p2=Persona(); 
   p.nombre="JUAN";
   p.edad=30;
   p.estatura=1.70;

   //imprimir verialbels dentro de un string
  print("Nombre: ${p.nombre} ");
  print("edad: ${p.edad}");
}

//excatamente lo mismo
// Persona p = Persona();
// var p = Persona();
// Persona p = new Persona();


//SIGUE R01