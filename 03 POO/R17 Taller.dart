class Taller {
  static final String nombre = 'Taller Central';
  static String mensajeGeneral = 'Bienvenido al Taller';
  static int _totalReparaciones = 0;

  static void cambiarMensaje(String nuevo) {
    mensajeGeneral = nuevo;
  }

  static void incrementarContador() {
    _totalReparaciones++;
  }

  static int obtenerReparaciones() {
    return _totalReparaciones;
  }
}

class Empleado {
  final String nombre;
  Empleado(this.nombre);

  void actualizarMensajeDelTaller(String texto) {
    Taller.cambiarMensaje(texto);
  }
}

class Vehiculo {
  final String placa;
  late String diagnostico;
  String estado = 'Pendiente';
  dynamic extraInfo;

  Vehiculo(this.placa);

  void registrarDiagnostico(String texto) {
    diagnostico = texto;
    estado = 'Reparado';
    Taller.incrementarContador();
  }

  void resumen() {
    print('Vehículo: $placa, Estado: $estado, Diagnóstico: $diagnostico');
    print('Taller: ${Taller.nombre}, Mensaje: ${Taller.mensajeGeneral}');
  }
}

void main() {
  var empleado = Empleado('Carlos');
  empleado.actualizarMensajeDelTaller('¡Bienvenidos al servicio rápido!');

  var v1 = Vehiculo('ABC123');
  v1.registrarDiagnostico('Cambio de aceite');
  v1.extraInfo = 2024.5;

  var v2 = Vehiculo('XYZ789');
  v2.registrarDiagnostico('Revisión de frenos');
  v2.extraInfo = 2025.7;

  v1.resumen();
  v2.resumen();

  print('Total reparaciones: ${Taller.obtenerReparaciones()}');
}
