import 'package:flutter/material.dart';
import 'pages/pantalla_bienvenida.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Carretera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaBienvenida(),
    );
  }
}
