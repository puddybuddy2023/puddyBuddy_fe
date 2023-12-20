import 'package:flutter/material.dart';

class User {
  late int preferId;
  late int userId;
  late String breedTagID;
  late String personalColorId;
  late String name;
  late String chest;
  late String back;

  User({
    required this.preferId,
    required this.userId,
    required this.breedTagID,
    required this.personalColorId,
    required this.name,
    required this.chest,
    required this.back,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        preferId: json['preferId'],
        userId: json['userId'],
        breedTagID: json['breedTagID'],
        personalColorId: json['personalColorId'],
        name: json['name'],
        chest: json['chest'],
        back: json['back']);
  }
}