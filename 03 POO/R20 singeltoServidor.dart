class ServidorCorreo {
  // instancia única
  static final ServidorCorreo _instancia = ServidorCorreo._crearInstancia();

  // constructor privado
  ServidorCorreo._crearInstancia();

  // factory que devuelve siempre la misma instancia
  factory ServidorCorreo() => _instancia;

  bool _conectado = false;

  bool get estaConectado => _conectado;

  void conectar() {
    if (!_conectado) {
      _conectado = true;
      print("Servidor conectado");
    } else {
      print("Ya existe una conexión activa");
    }
  }

  void enviarCorreo(String destinatario, String asunto) {
    if (_conectado) {
      print("Enviando correo a $destinatario con asunto: $asunto");
    } else {
      print("No se puede enviar, servidor desconectado");
    }
  }

  void desconectar() {
    if (_conectado) {
      _conectado = false;
      print("Servidor desconectado");
    } else {
      print("No hay conexión activa");
    }
  }
}


// import 'servidor_correo.dart';

void main() {
  // 1. Crear dos referencias distintas
  var servidor1 = ServidorCorreo();
  var servidor2 = ServidorCorreo();

  // 2. Conectar con una referencia
  servidor1.conectar();

  // 3. Enviar correos con ambas referencias
  servidor1.enviarCorreo("carlos@mail.com", "Bienvenida");
  servidor2.enviarCorreo("maria@mail.com", "Recordatorio");

  // 4. Verificar si apuntan a la misma instancia
  print("¿Son la misma instancia? ${servidor1 == servidor2}");

  // 5. Imprimir si está conectado
  print("¿Servidor conectado? ${servidor1.estaConectado}");

  // 6. Desconectar
  servidor2.desconectar();
}
