
import 'dart:io';

class PersonData {
  String nom;
  String prenom;
  int age;
  String sexe;
  DateTime dateNaissance;
  File photoPath; // Chemin de la photo

  PersonData({
    required this.nom,
    required this.prenom,
    required this.age,
    required this.sexe,
    required this.dateNaissance,
    required this.photoPath,
  });
}

