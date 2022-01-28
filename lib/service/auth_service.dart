import 'package:firebase/ui/auth/otp.dart';
import 'package:firebase/utils/exception_handlers/auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> registerWithEmail(String email, String password) async {
    var credentinal = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentinal.user;
  }

  registerWithPhoneNumber(String phoneNumber,name) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (signInWithCredential) async {
        print('verificationCompleted');
        await _auth.signInWithCredential(signInWithCredential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        var exceptionCode = AuthExceptionHandler.handleException(exception);
        var exceptionMessage =
            AuthExceptionHandler.generateExceptionMessage(exceptionCode);
        Get.showSnackbar(GetSnackBar(
          title: 'Hata',
          message: exceptionMessage,
          duration: const Duration(seconds: 1),
        ));
      },
      codeSent: (verificationId, forceResendingToken) {
        Get.to(() => OtpScreen(verificationId: verificationId,name:name));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('codeAutoRetrievalTimeout');
      },
    );
  }

  Future<User?> phoneNumberControl(String smsCode, verificationId) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    var userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<User?> registerWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    var account = await googleSignIn.signIn();
    if (account != null) {
      var auth = await account.authentication;
      if (auth.accessToken != null && auth.idToken != null) {
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken);
        var userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    var credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await _auth.signOut();
    googleSignIn.signOut();
  }

  User? currentUser() {
    return _auth.currentUser;
  }

}
