import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tp_formulaire/models/user_data.dart';

class ResultPage extends StatelessWidget {
  final PersonData person;

  ResultPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Résultat')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${person.nom}'),
            Text('Prénom: ${person.prenom}'),
            Text('Âge: ${person.age}'),
            Text('Sexe: ${person.sexe}'),
            Text('Date de naissance: ${person.dateNaissance}'),
            if (person.photoPath != null) ...[
              SizedBox(height: 20),
              Text('Photo choisie :'),
              SizedBox(height: 10),
              Image.file(File(person.photoPath!.path)),
            ],
          ],
        ),
      ),
    );
  }
}
