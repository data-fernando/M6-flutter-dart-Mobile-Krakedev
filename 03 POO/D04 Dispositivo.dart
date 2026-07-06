abstract class Dispositivo{
  int codigo;
  String marca;
  int tipo;


  Dispositivo(this.codigo,this.marca,this.tipo);

  void imprrimir(){
    print("soy un dispositivo");
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+" soy un dispositivo";
  }

  //metodo abstracto sin {}
  void registrarInventario();

}