import 'package:flutter/material.dart';
import 'product.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Basic List';
    const products = [
      Product(name: 'condoms'),
      Product(name: 'Lube'),
      Product(name: 'zip ties')
    ];
    const products2 = [
      Product(name: 'Chemical equipment'),
      Product(name: 'Bleach'),
      Product(name: 'baking powder')
    ];
    const products3 = [
      Product(name: 'leash'),
      Product(name: 'dog collar(for adults)'),
      Product(name: 'dog bowl')
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Map'),
              onTap: () {
                // Navigate to the Map page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ShoppingList(products: products)),
                );
              },
            ),
             ListTile(
              leading: Icon(Icons.list),
              title: Text('Map'),
              onTap: () {
                // Navigate to the Map page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingList(products: products2)),
                );
              },
            ),
             ListTile(
              leading: Icon(Icons.list),
              title: Text('Map'),
              onTap: () {
                // Navigate to the Map page when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingList(products: products3)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
