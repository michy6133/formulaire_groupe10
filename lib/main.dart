import 'package:flutter/material.dart';
import 'package:tp_formulaire/page/showadd.dart';
import 'package:tp_formulaire/models/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ShowAddPage(),
    );
  }
}
