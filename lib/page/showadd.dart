import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tp_formulaire/models/user_data.dart';
import 'form_page.dart';

class ShowAddPage extends StatefulWidget {
  const ShowAddPage({Key? key}) : super(key: key);

  @override
  _ShowAddPageState createState() => _ShowAddPageState();
}

class _ShowAddPageState extends State<ShowAddPage> {
  UserData? _userData;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? backgroundImage;

    if (_userData != null && _userData!.imagePath != null) {
      backgroundImage = FileImage(File(_userData!.imagePath));
    } else {
      backgroundImage = const AssetImage('assets/images/default_image.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: _userData != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: backgroundImage,
            ),
            const SizedBox(height: 16.0),
            Text('Nom: ${_userData!.firstName} ${_userData!.lastName}'),
            const SizedBox(height: 8.0),
            Text('Âge: ${_userData!.age}'),
            const SizedBox(height: 8.0),
            Text('Genre: ${_userData!.gender}'),
            const SizedBox(height: 8.0),
            Text('Date de naissance: ${_userData!.dateOfBirth.toString().split(' ')[0]}'),
          ],
        ),
      )
          : Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormPage()),
            ).then((value) {
              if (value != null) {
                setState(() {
                  _userData = value as UserData;
                });
              }
            });
          },
          child: const Text('Aller au formulaire'),
        ),
      ),
    );
  }
}
