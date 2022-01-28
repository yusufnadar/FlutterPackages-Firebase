import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? profilePhoto;

  UserModel(
      {this.email, this.id, this.name, this.phoneNumber, this.profilePhoto});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        id: json['id'],
        name: json['name'],
        profilePhoto: json['profilePhoto'],
      );

  factory UserModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> source) =>
      UserModel.fromJson(source.data()!);
}

