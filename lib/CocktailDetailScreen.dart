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
              'Instrucciones: ${cocktail['strInstructions'] ?? 'No hay instrucciones disponibles.'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Text('Ingredientes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            for (int i = 1; i <= 15; i++) 
              if (cocktail['strIngredient$i'] != null && cocktail['strMeasure$i'] != null)
                Text('${cocktail['strIngredient$i']} - ${cocktail['strMeasure$i']}'),
          ],
        ),
      ),
    );
  }
}
