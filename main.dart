import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'MyCustomFrom.dart';

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
