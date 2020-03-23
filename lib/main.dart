import 'package:flutter/material.dart';
import 'services/authHandler.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFF4c8bf5),
      theme: ThemeData(
          accentColor: Color(0xFF4c8bf5),
          primaryColor: Color(0xFF4c8bf5)
      ),
      debugShowCheckedModeBanner: false,
      title: 'DSC App',
      home: AuthHandler(),
    );
  }
}
