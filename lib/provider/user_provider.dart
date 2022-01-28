import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/user_model.dart';
import 'package:firebase/service/auth_service.dart';
import 'package:firebase/service/storageService.dart';
import 'package:firebase/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userService = UserService();
  final authService = AuthService();
  final storageService = StorageService();
  UserModel user = UserModel();

  UserProvider(){
    currentUser();
  }

  Future<void> updateUser(String name, String id) async {
    var isResult = await userService.updateUser(name, id);
    if (isResult == true) {
      var user = await userService.readUser(id);
      this.user = user!;
      notifyListeners();
    }
  }

  Future<void> currentUser() async {
    User? firebaseUser = authService.currentUser();
    if (firebaseUser != null) {
      user = (await userService.readUser(firebaseUser.uid))!;
      notifyListeners();
    }
  }

  Future<void> updateProfilePhoto(File? photo, String? id) async{
    String? url = await storageService.updateProfilePhoto(photo);
    if(url != null){
      var result = await userService.updateProfilePhoto(url,id!);
      if(result == true){
        user = (await userService.readUser(id))!;
        notifyListeners();
      }
    }else{
      print('url null');
    }
  }

}
