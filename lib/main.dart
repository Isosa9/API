import 'package:flutter/material.dart';
import 'screens/cocktail_list_screen.dart';
import 'screens/detail_drink_screen.dart';

void main() {
  runApp(CocktailsApp());
}

class CocktailsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cocktails App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CocktailsHomePage(),
    );
  }
}

class CocktailsHomePage extends StatefulWidget {
  @override
  _CocktailsHomePageState createState() => _CocktailsHomePageState();
}

class _CocktailsHomePageState extends State<CocktailsHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navegación en base a la selección del usuario
    switch (index) {
      case 0:
        // Mantenerse en la página de inicio
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CocktailListScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailDrinkScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to the Cocktails App'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        elevation: 0,
        toolbarTextStyle: TextStyle(color: Colors.black),
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            CocktailCard(category: 'Cocktails', name: 'Mojito'),
            SizedBox(height: 16.0),
            CocktailCard(category: 'Shots', name: 'Tequila'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'List Drinks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CocktailCard extends StatelessWidget {
  final String category;
  final String name;

  CocktailCard({required this.category, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category: $category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            name,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 50,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
