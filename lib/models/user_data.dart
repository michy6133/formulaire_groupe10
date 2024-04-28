import 'dart:io';

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String imagePath;
  final DateTime birthDate;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.imagePath,
    required this.birthDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      imagePath: json['imagePath'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  get dateOfBirth => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'imagePath': imagePath,
      'birthDate': birthDate.toIso8601String(),
    };
  }
}
