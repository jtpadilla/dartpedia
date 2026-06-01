// dart:io provee acceso a stdin/stdout y operaciones del sistema operativo
import 'dart:io';

// Las constantes con 'const' se evaluan en tiempo de compilacion y no cambian nunca
const version = '0.0.1';

// 'void' significa que la funcion no retorna ningun valor
// List<String> es un tipo generico: una lista que solo contiene Strings
void main(List<String> arguments) {
  // 'if/else if/else' funciona igual que en otros lenguajes
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'search') {
    // 'final' declara una variable que solo se asigna una vez (inmutable en referencia)
    // El operador ternario: condicion ? valorSiTrue : valorSiFalse
    // sublist(1) retorna una nueva lista desde el indice 1 en adelante (sin el primer elemento)
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

// El signo ? despues de List<String> indica que el parametro puede ser null (nullable)
// En Dart, los tipos son non-nullable por defecto; el ? permite aceptar null como valor valido
void searchWikipedia(List<String>? arguments) {
  // 'final' sin inicializar: Dart permite declarar y asignar despues, pero solo una vez
  // El tipo String es explicito aqui, aunque Dart puede inferirlo automaticamente
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    // stdin.readLineSync() lee una linea del teclado; retorna String? (puede ser null)
    // El operador ?? (null-coalescing) retorna el valor derecho si el izquierdo es null
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    // join(' ') concatena todos los elementos de la lista separados por un espacio
    articleTitle = arguments.join(' ');
  }

  // Las comillas dobles dentro del String se escapan con backslash \"
  print('Looking up articles about "$articleTitle". Please wait.');
  print('Here ya go!');
  print('(Pretend this is an article about "$articleTitle")');
}

void printUsage() {
  print(
      "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}
