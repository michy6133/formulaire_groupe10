import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp_formulaire/models/user_data.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptConditions = false;
  DateTime? _selectedDate;
  late String _imagePath;
  late String _firstName;
  late String _lastName;
  late int _age;
  late String _gender;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Prénom',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                }
                return null;
              },
              onSaved: (value) {
                _firstName = value!;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nom',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                return null;
              },
              onSaved: (value) {
                _lastName = value!;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Âge',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre âge';
                }
                return null;
              },
              onSaved: (value) {
                _age = int.parse(value!);
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Genre',
              ),
              value: _gender,
              items: const [
                DropdownMenuItem(value: 'Homme', child: Text('Homme')),
                DropdownMenuItem(value: 'Femme', child: Text('Femme')),
                DropdownMenuItem(value: 'Autre', child: Text('Autre')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner votre genre';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? 'Sélectionnez une date'
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: _imagePath.isNotEmpty
                      ? DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(_imagePath)),
                  )
                      : null,
                ),
                child: _imagePath.isEmpty
                    ? const Icon(Icons.add_a_photo)
                    : null,
              ),
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('J\'accepte les conditions'),
              value: _acceptConditions,
              onChanged: (value) {
                setState(() {
                  _acceptConditions = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _acceptConditions) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, UserData(
                    firstName: _firstName,
                    lastName: _lastName,
                    age: _age,
                    gender: _gender,
                    imagePath: _imagePath,
                    id: 0,
                    birthDate: _selectedDate!,
                  ));
                } else {
                  // Handle form validation errors
                }
              },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
