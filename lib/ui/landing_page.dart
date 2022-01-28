import 'package:firebase/provider/user_provider.dart';
import 'package:firebase/ui/auth/register.dart';
import 'package:firebase/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  final isLogin;

  const LandingPage({Key? key, this.isLogin}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (_userProvider.user.id != null) {
                return const HomePage();
              } else {
                Provider.of<UserProvider>(context, listen: false).currentUser();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Bir hata var ' + snapshot.error.toString()),
              );
            } else {
              return const Register();
            }
          }),
    );
  }

}
