class Direccion{
  String calleprincipal;
  String callesecundaria;
  String? referencia;

  // Direccion(this.calleprincipal,this.callesecundaria,String referencia){
  //   this.referencia=referencia;
  // }
  // opcional
  Direccion(this.calleprincipal,this.callesecundaria,[this.referencia]){
    this.referencia=referencia;
  }

  @override
  String toString() {
    return 'Direccion(calleprincipal: $calleprincipal, callesecundaria: $callesecundaria, referencia: $referencia)';
  }
  

}

void main(){
  var dir1 = Direccion("Av. Siempre Viva", "Calle Falsa");
  var dir2 = Direccion("Av. Siempre Viva", "Calle Falsa", "Frente al parque");
  print(dir1.toString());
  print(dir2.toString());
}