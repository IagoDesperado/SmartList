import 'package:flutter/material.dart';

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