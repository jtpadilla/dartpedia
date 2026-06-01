// dart:io provee acceso a stdin/stdout y operaciones del sistema operativo
import 'dart:io';
// dart:convert provee jsonDecode/jsonEncode para parsear y formatear JSON
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  } else if (arguments.first == 'search' || arguments.first == 'wikipedia') {
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
void searchWikipedia(List<String>? arguments) async {
  final String articleTitle;

  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title.');
    final inputFromStdin = stdin.readLineSync(); // Read input
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting.');
      return; // Exit the function if no valid input
    }
    articleTitle = inputFromStdin;
  } else {
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait.');

  // Call the API and await the result
  var articleContent = await getWikipediaArticle(articleTitle);
  // jsonDecode parsea el String JSON a un objeto Dart (Map/List)
  // JsonEncoder.withIndent formatea el objeto de vuelta a JSON con sangria legible
  final prettyJson = JsonEncoder.withIndent('  ').convert(jsonDecode(articleContent));
  print(prettyJson);

}

void printUsage() {
  print(
      "The following commands are valid: 'help', 'version', 'wikipedia <ARTICLE-TITLE>'"
  );
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );
  final response = await http.get(url); // Make the HTTP request

  if (response.statusCode == 200) {
    return response.body; // Return the response body if successful
  }

  // Return an error message if the request failed
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}

