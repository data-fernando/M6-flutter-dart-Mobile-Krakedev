class Estudiante{
    final String nombre;
    late String cuaderno;
    static String pizarra='Limpia';
    static const escuela='San Juan';
    //privado con _
    static int _contadorEstudiantes=0;

    static obtenerContadorEstudiantes(){
      return _contadorEstudiantes;
    }

    Estudiante(this.nombre){
      _contadorEstudiantes++;
    };

    void limpiarPizarra(){
      pizarra = ''; 
      print(pizarra);
    }
    void escribirPizarra(String mensaje){
      pizarra = mensaje;
      print(pizarra);
    }

    
    
      }


    void main(){

      print('Estudiante: ${Estudiante.obtenerContadorEstudiantes()}');
      print('Pizarra: ${Estudiante.pizarra}');
      print('Escuela: ${Estudiante.escuela}');

      var estudiante1 = Estudiante('Juan');
      estudiante1.cuaderno = 'Matematicas';
      print('Cuaderno de ${estudiante1.nombre}: ${estudiante1.cuaderno}');
      var estudiante2 = Estudiante('Maria');
      estudiante2.cuaderno = 'Ciencias';
      print('Cuaderno de ${estudiante2.nombre}: ${estudiante2.cuaderno}');
      
      var estudiante3 = Estudiante('Pedro');
      estudiante3.cuaderno = 'Historia';
      print('Cuaderno de ${estudiante3.nombre}: ${estudiante3.cuaderno}');

      print(Estudiante.pizarra);

      estudiante1.escribirPizarra("mensaje de ${estudiante1.nombre}");
      print(Estudiante.pizarra);
      
      estudiante2.escribirPizarra("mensaje de ${estudiante2.nombre}");
      print(Estudiante.pizarra);
      
      estudiante3.escribirPizarra("mensaje de ${estudiante3.nombre}");
      print(Estudiante.pizarra);

      estudiante1.limpiarPizarra();
      print(Estudiante.pizarra);
      
    }
    
    
  

