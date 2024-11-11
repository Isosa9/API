import 'package:flutter/material.dart';

void main() {
  runApp(DetailDrinkApp());
}

class DetailDrinkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Drink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailDrinkScreen(),
    );
  }
}

class DetailDrinkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Drink'),
        automaticallyImplyLeading: false, // Prevent the default back button
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back when the "Back" button is pressed
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Detail Drink',
                style: TextStyle(fontSize: 20, color: Color(0xFF444444)),
              ),
              SizedBox(height: 20),
              // Drink Details
              DetailRow(label: 'Name Drink'),
              DetailRow(label: 'Description'),
              DetailRow(label: 'Origin'),
              DetailRow(label: 'Ingredients', isChecked: true),
              DetailRow(label: 'Glass', isChecked: true),
              DetailRow(label: 'Feedback', isChecked: false),
              SizedBox(height: 20),
              // Footer links
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Home', style: TextStyle(fontSize: 14)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('List Drinks', style: TextStyle(fontSize: 14, color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Search', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final bool isChecked;

  const DetailRow({
    required this.label,
    this.isChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {},
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
