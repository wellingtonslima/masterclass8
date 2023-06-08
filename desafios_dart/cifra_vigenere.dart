import 'dart:io';
import 'dart:math';

void main() {
  var texto;
  var textoUppercase;
  
  print("Digite um texto para ser codificado");
  texto = stdin.readLineSync();
  textoUppercase = texto.toString().toUpperCase();
  textoUppercase = textoUppercase.toString().replaceAll(" ", "");

  String chave = geradorChave(textoUppercase);
  String textoCriptografado = String.fromCharCodes(encode(textoUppercase, chave));
  String textoDescriptografado = String.fromCharCodes(decode(textoCriptografado,chave));

  print("Texto criptografado:");
  print(textoCriptografado);
  print("Texto descriptografado:");
  print(textoDescriptografado);
  
}

/**
 * Gerador de Key randômica.
 * Irá gerar uma chave randômica com a quantidade de caracteres do texto a ser criptografado
 */
  String geradorChave(String texto){
  List <int> chave = [];
  for (var i = 0; texto.length > i; i++) {
    chave.add(Random.secure().nextInt(25) + 65);
  }

  return String.fromCharCodes(chave);
}

/**
 * Encode - Retorna o texto criptografado
 */
encode(String texto, String chave){
  List<int> encoded = [];
  for (var i = 0; i < texto.length; i++) {
    if(int.tryParse(texto[i]) == null){
      encoded.add(calcularNovoChar(texto.codeUnitAt(i), chave.codeUnitAt(i)));
    }else if(int.tryParse(texto[i]) != null){
      encoded.add(texto.codeUnitAt(i));
    }
  }
  return encoded;
}

/**
 * Decode - Retorna o texto descriptografados
 */
decode(String texto, String chave){
  List<int> decoded = [];
  for (var i = 0; i < texto.length; i++) {
    if(int.tryParse(texto[i]) == null){
      decoded.add(calcularAntigoChar(texto.codeUnitAt(i), chave.codeUnitAt(i)));
    }else if(int.tryParse(texto[i]) != null){
      decoded.add(texto.codeUnitAt(i));
    }
  }
  return decoded;
}

int calcularNovoChar(char1, char2){
  int soma = 0;
  int? resto;
  int charCodeA = "A".codeUnitAt(0);
  int novoChar = 0;

  print(char1);
  soma = char1 + char2;
  resto = soma % 26;
  novoChar = resto + charCodeA;

  return novoChar;
}

int calcularAntigoChar(char1 , char2){
  int soma = 0;
  int? resto;
  int novoChar = 0;
  int charCodeA = "A".codeUnitAt(0);

  soma = char1 - char2;
  soma += 26;
  resto = soma % 26;
  novoChar = resto + charCodeA;

  return novoChar;
}