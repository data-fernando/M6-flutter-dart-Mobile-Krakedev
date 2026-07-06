import 'D03 Animal.dart';

class Gato extends Animal{
    @override
    void dormir() {
      // TODO: implement dormir
      print("El gato esta durmiendo");
    }
    @override
    void comer() {
      // TODO: implement comer
      print("El gato esta comiendo");
    }

    void maullar(){
      print("El gato esta maullando");
    }
}