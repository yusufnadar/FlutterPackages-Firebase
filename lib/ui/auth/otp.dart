import 'package:firebase/provider/auth_provider.dart';
import 'package:firebase/provider/user_provider.dart';
import 'package:firebase/ui/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final verificationId;
  final name;

  const OtpScreen({Key? key, this.verificationId, this.name}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Screen'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'En az 6 karakter giriniz';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Code',
                    prefixIcon: Icon(Icons.messenger),
                  ),
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _authProvider.phoneNumberControl(
                          controller.text, widget.verificationId,widget.name).then((value) async {
                            if(value != null){
                              await Provider.of<UserProvider>(context,listen: false).currentUser();
                              Get.offAll(()=>const LandingPage());
                            }
                      });
                    }
                  },
                  child: const Text(
                    'Check Code',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
