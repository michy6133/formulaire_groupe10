import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tp_formulaire/page/result_page.dart';
import 'package:tp_formulaire/models/user_data.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _ageController;
  late TextEditingController _sexeController;
  late TextEditingController _dateNaissanceController;
  late File _photoPath; // Utilisation de File
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Clé pour le formulaire

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _ageController = TextEditingController();
    _sexeController = TextEditingController();
    _dateNaissanceController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _sexeController.dispose();
    _dateNaissanceController.dispose();
    super.dispose();
  }

  Future<void> _chooseImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photoPath = File(pickedFile.path); // Convertir en File
      }
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateNaissanceController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) { // Vérification de la validité du formulaire
      PersonData person = PersonData(
        nom: _nomController.text,
        prenom: _prenomController.text,
        age: int.parse(_ageController.text),
        sexe: _sexeController.text,
        dateNaissance: DateFormat('dd/MM/yyyy').parse(_dateNaissanceController.text),
        photoPath: _photoPath, // Utilisation de File
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage(person: person)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulaire')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez remplir le champ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _prenomController,
                  decoration: InputDecoration(labelText: 'Prénom'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez remplir le champ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Âge'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez remplir le champ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sexeController,
                  decoration: InputDecoration(labelText: 'Sexe'),
                ),
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _dateNaissanceController,
                      decoration: InputDecoration(labelText: 'Date de naissance'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _chooseImage,
                  child: Text('Choisir une photo'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Valider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
