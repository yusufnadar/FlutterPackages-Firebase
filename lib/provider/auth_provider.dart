import 'package:firebase/model/user_model.dart';
import 'package:firebase/provider/user_provider.dart';
import 'package:firebase/service/auth_service.dart';
import 'package:firebase/service/user_service.dart';
import 'package:firebase/utils/exception_handlers/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final authService = AuthService();
  final userService = UserService();
  UserModel? user = UserModel();


  Future registerWithEmail(String email, String password, String name) async {
    try {
      var user = await authService.registerWithEmail(email, password);
      user!.sendEmailVerification();
      FirebaseAuth.instance.signOut();
      await userService.saveUser(email, name, user.uid);
      return 'Mailinize onay kodu gönderilmiştir';
    } catch (e) {
      var exception = AuthExceptionHandler.handleException(e);
      return AuthExceptionHandler.generateExceptionMessage(exception);
    }
  }

  void registerWithPhoneNumber(String phoneNumber, name) async {
    try {
      await authService.registerWithPhoneNumber(phoneNumber, name);
    } catch (e) {
      debugPrint('hata var $e');
    }
  }

  Future<UserModel?> phoneNumberControl(
      String smsCode, verificationId, name) async {
    try {
      User? user2 =
          await authService.phoneNumberControl(smsCode, verificationId);
      var result = await userService.userController(user2!.uid);
      if (result != null) {
        user = result;
        notifyListeners();
        return user;
      } else {
        await userService.saveUser(user2.phoneNumber, user2.uid, name,
            isEmail: false);
        user = (await userService.readUser(user2.uid))!;
        notifyListeners();
        return user;
      }
    } catch (e) {
      var exceptionCode = AuthExceptionHandler.handleException(e);
      var exceptionMessage =
          AuthExceptionHandler.generateExceptionMessage(exceptionCode);
      Get.showSnackbar(GetSnackBar(
        title: 'Hata',
        message: exceptionMessage,
        duration: const Duration(seconds: 1),
      ));
    }
  }

  Future registerWithGoogle(context) async {
    try {
      var user2 = await authService.registerWithGoogle();
      var result = await userService.userController(user2!.uid);
      if (result != null) {
        user = result;
        notifyListeners();
        return user;
      } else {
        await userService.saveUser(user2.email!, user2.displayName!, user2.uid);
        await Provider.of<UserProvider>(context,listen: false).currentUser();
        user = (await userService.readUser(user2.uid))!;
        notifyListeners();
        return user;
      }
    } catch (e) {
      return e;
    }
  }

  Future loginWithEmail(String email, String password) async {
    try {
      var firebaseUser = await authService.loginWithEmail(email, password);
      if (firebaseUser!.emailVerified) {
        user = (await userService.readUser(firebaseUser.uid))!;
        notifyListeners();
        return user;
      } else {
        return 'Lütfen mailinize gelen kodu onaylayınız';
      }
    } catch (e) {
      var exceptionCode = AuthExceptionHandler.handleException(e);
      var exceptionMessage =
          AuthExceptionHandler.generateExceptionMessage(exceptionCode);
      Get.showSnackbar(GetSnackBar(
        title: 'Hata',
        message: exceptionMessage,
        duration: const Duration(seconds: 1),
      ));
      return e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      authService.signOut();
    } catch (e) {
      Get.snackbar('Hata', 'Çıkış Yapılamadı $e');
    }
  }


}
