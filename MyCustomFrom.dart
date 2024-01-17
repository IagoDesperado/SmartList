import 'package:flutter/material.dart';
import 'LogoState.dart';
import 'product.dart';
import 'MyHomePage.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
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
