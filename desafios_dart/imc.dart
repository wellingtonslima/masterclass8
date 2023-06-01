/*
DESAFIO MASTERCLASS

O (IMC) índice de massa corporal é baseado na altura e peso do individuo.
O calculo é representado por Dividir o peso pela Altura ao quadradro²

Cria uma função que realize o calculo de IMC.
*/


main(){
  double altura = 1.77;
  double peso = 72.0;

  print(calcularIMC(altura, peso));
}

double calcularIMC(double altura, double peso){
  double imc = peso / (altura * altura);
  return imc;
}