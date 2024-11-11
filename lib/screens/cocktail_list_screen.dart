import 'package:cocktails_app/cocktail_service.dart';
import 'package:flutter/material.dart';

class CocktailListScreen extends StatefulWidget {
  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<Map<String, dynamic>> _cocktails = [];

  @override
  void initState() {
    super.initState();
    _fetchCocktails();
  }

void _fetchCocktails() async {
  try {
    var cocktails = await CocktailService().searchCocktailByName('');
    setState(() {
      _cocktails = cocktails;
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _isLoading = false;
      _errorMessage = 'Error al cargar los cócteles: $e';  // Mostrar el error completo
    });
    print('Error en la API: $e');  // Imprimir el error en la consola para depuración
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Cócteles'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())  // Muestra un indicador de carga
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))  // Muestra mensaje de error si hay un problema
              : ListView.builder(
                  itemCount: _cocktails.length,
                  itemBuilder: (context, index) {
                    var cocktail = _cocktails[index];
                    return ListTile(
                      leading: cocktail['strDrinkThumb'] != null
                          ? Image.network(
                              cocktail['strDrinkThumb'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : null,
                      title: Text(cocktail['strDrink'] ?? 'Cóctel desconocido'),
                      subtitle: Text(cocktail['strCategory'] ?? 'Sin categoría'),
                      onTap: () {
                        // Navega a la pantalla de detalles del cóctel
                      },
                    );
                  },
                ),
    );
  }
}
