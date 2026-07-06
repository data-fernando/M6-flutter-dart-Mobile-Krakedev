import 'D04 Dispositivo.dart';

class Celular extends Dispositivo{



  Celular(super.codigo,super.marca,super.tipo);

  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+" soy un celular";
  }

  @override
  void imprrimir() {
    // TODO: implement imprrimir
    super.imprrimir();

  }
  @override
  void registrarInventario() {
    // TODO: implement registrarInventario
    print("registrando inventario del celular ...");
  }

}


void main(){
  var celular1 = Celular(1,"Samsung",2);
  print(celular1.toString());
  celular1.imprrimir();
  celular1.registrarInventario();
}
