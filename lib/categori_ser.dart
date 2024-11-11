import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Apiser());
}

class Apiser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktail App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CategoryListScreen(),
    );
  }
}

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['drinks'] ?? [];
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categorías de Cócteles')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron categorías.'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var category = categories[index]['strCategory'];
                return ListTile(
                  title: Text(category),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CocktailListScreen(category: category),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CocktailListScreen extends StatelessWidget {
  final String category;
  CocktailListScreen({required this.category});

  Future<List<dynamic>> fetchCocktails() async {
    final response = await http.get(Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['drinks'] ?? [];
    } else {
      throw Exception('Error al obtener los cócteles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Cócteles')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchCocktails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()

          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron cócteles.'));
          } else {
            final cocktails = snapshot.data!;
            return ListView.builder(
              itemCount: cocktails.length,
              itemBuilder: (context, index) {
                var cocktail = cocktails[index];
                return ListTile(
                  title: Text(cocktail['strDrink']),
                  leading: Image.network(cocktail['strDrinkThumb']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CocktailDetailScreen(
                          name: cocktail['strDrink'],
                          imageUrl: cocktail['strDrinkThumb'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CocktailDetailScreen extends StatelessWidget {
  final String name;
  final String imageUrl;

  CocktailDetailScreen({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl), // Imagen del cóctel
            SizedBox(height: 20),
            Text(
              name, // Nombre del cóctel
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
