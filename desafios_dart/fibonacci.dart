
/*
DESAFIO MASTERCLASS

Na matemática, a sucessão de Fibonacci (ou sequência de Fibonacci), é uma sequência de números inteiros, 
começando normalmente por 0 e 1, na qual cada termo subsequente corresponde à soma dos dois anteriores. 
A sequência recebeu o nome do matemático italiano Leonardo de Pisa, mais conhecido por Fibonacci, que descreveu, 
no ano de 1202, o crescimento de uma população de coelhos, a partir desta. Esta sequência já era, no entanto, 
conhecida na antiguidade.

Implemente a sequencia fibonacci com funcões recursivamente usando o Dart.
*/
import 'dart:io';

main (){

  var valorInformado;
  int ?qtdTermo;
  bool isRunning = true;
  
  print("\x1B[2J\x1B[0;0H");
  print("=== Sequencia de Fibonacci ===");
  print("Digite a quantidade de termos para calcular a sequencia de Fibonacci:");
  valorInformado = stdin.readLineSync();

  while(isRunning){
    print("\x1B[2J\x1B[0;0H");
    if(valorInformado != 's'){
      qtdTermo = int.tryParse(valorInformado);
      if(int.tryParse(valorInformado) != null){
        print("=== Sequencia fibonacci ===");
        sequenciaFibonacci(qtdTermo);
        print("=== Fim da sequencia fibonacci ===");
        isRunning = false;
        print("=== Fim do programa ===");
      }else{
        print("O valor digitado não é um inteiro.");
        print("Por favor, digite outro número, ou s para sair do programa.");
        valorInformado = stdin.readLineSync();
      }
    }else{
      isRunning = false;
      print("=== Fim do programa ===");
    }
  }
}

void sequenciaFibonacci(var qtdTermo){

  int numeroAnterior = 1;
  int numeroAtual;
  int somatorio = 0;
    
  for (int i = 0; i <= qtdTermo; i++) {
    numeroAtual = somatorio;
    somatorio = numeroAnterior + numeroAtual;
    print (somatorio);

    numeroAnterior = numeroAtual;
  }

}


