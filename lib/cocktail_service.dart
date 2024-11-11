import 'dart:convert';
import 'package:http/http.dart' as http;

class CocktailService {
  // Base URL de la API de TheCocktailDB
  final String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';

  // Función para buscar cócteles por nombre
  Future<List<Map<String, dynamic>>> searchCocktailByName(String name) async {
    // Crear la URL con el nombre del cóctel
    final url = Uri.parse('${baseUrl}search.php?s=$name');

    // Imprime la URL generada para que puedas verificarla
    print('Consultando URL: $url');

    try {
      // Realiza la solicitud GET
      final response = await http.get(url);

      // Verifica si la respuesta fue exitosa (código 200)
      if (response.statusCode == 200) {
        // Decodifica los datos JSON recibidos
        var data = json.decode(response.body);

        // Imprime los datos completos de la respuesta de la API
        print('Datos recibidos: $data');

        // Verifica si la clave 'drinks' contiene una lista y la retorna
        if (data['drinks'] != null && data['drinks'] is List) {
          return List<Map<String, dynamic>>.from(data['drinks']);
        } else {
          // Si no se encuentran cócteles, lanza una excepción
          throw Exception('No se encontraron cócteles');
        }
      } else {
        // Si la respuesta no es exitosa, lanza una excepción con el código de error
        throw Exception('Error en la búsqueda del cóctel, código: ${response.statusCode}');
      }
    } catch (e) {
      // En caso de error, lanza una excepción con el mensaje
      throw Exception('Error al hacer la solicitud: $e');
    }
  }
}
