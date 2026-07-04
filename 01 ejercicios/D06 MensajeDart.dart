class  Mensaje {
void saludar(String nombre,String apellido,String? apodo){
  print('Hola $nombre $apellido $apodo');
}

}

void main(){
    final msg=Mensaje();
    msg.saludar("juan", "perez", null);
}