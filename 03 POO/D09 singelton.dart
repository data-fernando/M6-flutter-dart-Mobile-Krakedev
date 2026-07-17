class ImpresoraCentral{


  static final ImpresoraCentral _instancia = ImpresoraCentral._crearInstancia();
  ImpresoraCentral._crearInstancia();
  factory ImpresoraCentral()=> _instancia;

  bool _conectada = false;

  bool get conectada => _conectada;

  void conectar(){
    _conectada = true;
    print("Impresora conectada");
  }
  void desconectar(){
    _conectada = false;
    print("Impresora desconectada");
  }

  void imprimir(String documento){
    print("Imprimiendo $documento");
  }
}

void main(){
  ImpresoraCentral impresora1 = ImpresoraCentral();
  impresora1.conectar();
  print("conectada: " + impresora1.conectada.toString());
  impresora1.imprimir("documento1");


  ImpresoraCentral impresora2 = ImpresoraCentral(); 
  impresora2.conectar();
  impresora2.desconectar();
  print("conectada: " + impresora1.conectada.toString());
  impresora1.imprimir("documento2");
  
  print("\n conectada: " + impresora1.conectada.toString());



  if(impresora1 == impresora2){
    print("son la misma impresora");
  }else{
    print("son diferentes impresoras");
  }


}