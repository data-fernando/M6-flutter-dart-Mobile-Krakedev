import 'D05 Clase Abstracta.dart';

class Cuadrado extends FiguraGeometrica{

  double lado;
  Cuadrado(super.color,this.lado);
  
  @override
  double calcularArea() {
    // TODO: implement calcularArea
    return lado * lado;
  }
  @override
  double calcularPerimetro() {
    // TODO: implement calcularPerimetro
    return 4 * lado;
    }
    @override
    String toString() {
      return "Cuadrado: color=$color, lado=$lado";
    }

}