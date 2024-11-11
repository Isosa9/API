import 'package:flutter/material.dart';

class CocktailDetailScreen extends StatelessWidget {
  final Map<String, dynamic> cocktail;

  CocktailDetailScreen({required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail['strDrink']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(cocktail['strDrinkThumb']),
            SizedBox(height: 16.0),
            Text(
              'Ingredientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(cocktail['strInstructions'] ?? 'No instructions available'),
            // Agrega más detalles aquí según lo necesites.
          ],
        ),
      ),
    );
  }
}
