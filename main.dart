import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final log = Logger('MainAppLogger');

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'SmartList';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
       theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 104, 149, 255),
            foregroundColor: Color.fromARGB(255, 253, 135, 255)//here you can give the text color
            ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 253, 135, 255),//here you can give the text color,
            backgroundColor: Color.fromARGB(255, 104, 149, 255),
          ),
        ),
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 253, 135, 255)),//here you can give the text color
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        backgroundColor:  Color.fromARGB(255, 104, 149, 255),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

//widget that contains the logo
class LogoState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset(
        'assets/logo.png', // path to the logo
        height: 100,
      ),
    );
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LogoState(), //display the logo
          //put the taxt bars in a container to limit their width
          Center(
            child:Container(
                width: 500, // Set the desired width
                  child: TextFormField(
                  //styling of the textbvars
                  style: TextStyle(color: Color.fromARGB(255, 68, 0, 255)), // Set text color
                  decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // Set background color
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid username';
              }
              return null;
            },
          ),
          ),
      ),
          Container(
            width: 500,  
            child:TextFormField(
              style: TextStyle(color: Color.fromARGB(255, 68, 0, 255)), // Set text color
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // Set background color
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ), 
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                //TODO: actually implement a database and save the data
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("The db hasn't been implemented yet so this is pretty meaningless.Just like life.")),
                  );
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
            );
                }
              },
              child: const Text('Log In'),
            ),
          ),
          Text('Forgot your password?')
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  static const appTitle = 'SmartList';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
      theme: ThemeData(
         appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 104, 149, 255),
            foregroundColor: Color.fromARGB(255, 253, 135, 255)//here you can give the text color
            ),
        scaffoldBackgroundColor: Color.fromARGB(255, 104, 149, 255), // Change this color to your desired background color
    ),
    );
  }
}

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({required this.products, super.key});

  final List<Product> products;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _shoppingCart = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: widget.products.map((product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ShoppingList(
        products: [
          Product(name: 'Product 1'),
          Product(name: 'Product 2'),
          ]
        );
      case 1:
        return Text(
          'Index 1: Business',
          style: optionStyle,
        );
      case 2:
        return Text(
          'Index 2: School',
          style: optionStyle,
        );
      default:
        return Container(); // You can return an empty container or handle the case as needed
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _buildPage(_selectedIndex),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 104, 149, 255),
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
          child: ListView(
          // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 135, 255),
              ),
              child: Text('Settings'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ),
      backgroundColor: Color.fromARGB(255, 104, 149, 255),
    );
  }
}
