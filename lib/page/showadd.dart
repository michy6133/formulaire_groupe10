import 'package:flutter/material.dart';
import 'package:tp_formulaire/page/form_page.dart';
import 'package:tp_formulaire/models/user_data.dart';

class ShowAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter une personne')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormPage()),
            );
          },
          child: Text('Ajouter une personne'),
        ),
      ),
    );
  }
}
