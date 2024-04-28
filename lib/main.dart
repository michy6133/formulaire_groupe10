import 'package:flutter/material.dart';
import 'package:tp_formulaire/page/showadd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowAddPage(),
    );
  }
}
