import 'package:flutter/material.dart';
import 'cocktail_service.dart';  // Asegúrate de que la ruta sea correcta

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  List<Map<String, dynamic>> _cocktails = [];

  // Crear una instancia de CocktailService
  final CocktailService _cocktailService = CocktailService();

  void _searchCocktails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Verifica si el texto está vacío
    if (_controller.text.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Por favor, ingrese el nombre de un cóctel.';
      });
      return;
    }

    try {
      // Realiza la búsqueda con el texto ingresado
      var cocktails = await _cocktailService.searchCocktailByName(_controller.text);
      setState(() {
        _cocktails = cocktails;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al cargar los cócteles: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar Cócteles"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese el nombre del cóctel',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchCocktails,
              child: Text('Buscar'),
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_errorMessage.isNotEmpty)
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            if (_cocktails.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _cocktails.length,
                  itemBuilder: (context, index) {
                    final cocktail = _cocktails[index];
                    return ListTile(
                      leading: cocktail['strDrinkThumb'] != null
                          ? Image.network(cocktail['strDrinkThumb'])
                          : null,
                      title: Text(cocktail['strDrink'] ?? 'Cóctel sin nombre'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
