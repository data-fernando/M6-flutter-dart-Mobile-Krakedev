import 'D04 Dispositivo.dart';

class Computador extends Dispositivo{
  int capacidadDisco;

  Computador(this.capacidadDisco,super.codigo,super.marca,super.tipo);
  
  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+" Capacidad de disco: $capacidadDisco";

   
  }
  @override
  void registrarInventario() {
    // TODO: implement registrarInventario
    print("registrando inventario de computadora ...");
  }

}

void main(){
  var computador1 = Computador(256,1,"Dell",1);
  print(computador1.toString());
  computador1.imprrimir();
  computador1.registrarInventario();
}
    