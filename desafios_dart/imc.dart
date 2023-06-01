/*
DESAFIO MASTERCLASS

O (IMC) índice de massa corporal é baseado na altura e peso do individuo.
O calculo é representado por Dividir o peso pela Altura ao quadradro²

Cria uma função que realize o calculo de IMC.
*/

import 'dart:io';

main(){
  double altura = 0.0;
  double peso = 0.0;
  bool isRunning = true;
  var valorDigitado;
  var valorDigitadoDouble;

  print("=== Cálculo de IMC ===");
  print('\n');
  while(isRunning){
    print("");
    print("Digite sua altura:");
    print("ex: 1.77");
    valorDigitado = stdin.readLineSync();
    valorDigitadoDouble = double.tryParse(valorDigitado);
    print("");
    if(valorDigitadoDouble != 's'){

      while(valorDigitadoDouble == null){
        print("");
        print("O valor digitado não é valido!");
        print("");
        print("Digite sua altura:");
        print("ex: 1.77");
        valorDigitado = stdin.readLineSync();
        valorDigitadoDouble = double.tryParse(valorDigitado);
      }
      
      if(valorDigitadoDouble is double){
        altura = valorDigitadoDouble;
      }
      print("");
      print("Digite seu peso:");
      print("ex: 46.800, 46");
      valorDigitado = stdin.readLineSync();
      valorDigitadoDouble = double.tryParse(valorDigitado);

      while(valorDigitadoDouble == null){
        print("");
        print("O valor digitado não é valido!");
        print("");
        print("Digite seu peso:");
        print("ex: 46.800, 46");
        valorDigitado = stdin.readLineSync();
        valorDigitadoDouble = double.tryParse(valorDigitado);
      }

      if(valorDigitadoDouble is double){
        peso = valorDigitadoDouble;
      }

      print("");
      print("O valor do seu IMC é: ");
      print(calcularIMC(altura, peso).toStringAsFixed(2));
      print(resultadoIMC(calcularIMC(altura, peso)));

      print("");
      print("Deseja fazer outro cálculo?");
      print("Digite s para sim ou n para não.");
      if(stdin.readLineSync() == "n"){
        isRunning = false;
      }
      
    }else{
      isRunning = false;
    }
  }
  
} 

double calcularIMC(double altura, double peso){
  double imc = peso / (altura * altura);

  return imc;
}

String resultadoIMC(double valorIMC){
  String resultado = "Não foi possível retornar um resultado";

  if(valorIMC < 18.5){
    resultado = "Você está abaixo do peso!";    
  }
  if (valorIMC >= 18.5 && valorIMC <= 24.9){
    resultado = "Você está com peso normal!";    
  }
  if (valorIMC >= 25 && valorIMC <= 29.9){
    resultado = "Você está acima do peso!";    
  }
  if (valorIMC >= 30 && valorIMC <= 34.9){
    resultado = "Você está com obesidade I";    
  }
  if (valorIMC >= 35 && valorIMC <= 39.9){
    resultado = "Você está com obesidade II";    
  }
  if (valorIMC > 40){
    resultado = "Você está com obesidade III";    
  }

  return resultado;
}