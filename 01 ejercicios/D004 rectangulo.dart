class Rectangula{
  int base=0;
  int altura=0;

  int calularArea(){
     return base*altura;
  }

  int calcularPerimetro(){
      return (base+altura)*2;
    
  }

  // Rectangula(int base , int altura){
  //   this.altura=altura;
  //   this.base=base;

  // }

  Rectangula(this.base , this.altura){
  }




}

  void main(){
      final r1=Rectangula(5,9);
      // r1.altura=5;
      // r1.base=8;
      print("perimetro: ${r1.calcularPerimetro()} area: ${r1.calularArea()}");
  }