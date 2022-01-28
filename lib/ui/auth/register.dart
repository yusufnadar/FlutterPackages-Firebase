import 'package:firebase/model/user_model.dart';
import 'package:firebase/provider/auth_provider.dart';
import 'package:firebase/provider/user_provider.dart';
import 'package:firebase/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isEmail = true;

  var sizedBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (isEmail)
                  Column(
                    children: [
                      emailInput(),
                      sizedBox,
                      nameInput(),
                      sizedBox,
                      passwordInput(),
                    ],
                  )
                else
                  Column(
                    children: [
                      nameInput(),
                      sizedBox,
                      phoneInput(),
                    ],
                  ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('Register With Email'),
                    Checkbox(
                        value: isEmail,
                        onChanged: (value) {
                          setState(() {
                            isEmail = value!;
                          });
                        }),
                  ],
                ),
                sizedBox,
                registerButton(authProvider, context),
                sizedBox,
                GestureDetector(
                  onTap: () {
                    Get.off(() => const Login());
                  },
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Hesabınız var mı? Giriş Yapın.',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                sizedBox,
                sizedBox,
                signInWithGoogle(authProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector signInWithGoogle(AuthProvider authProvider) {
    return GestureDetector(
      onTap: () {
        authProvider.registerWithGoogle(context).then((value) async {
          if (value.runtimeType == UserModel) {
            Get.snackbar('Başarılı', 'Başarıyla Giriş Yapıldı!',
                backgroundColor: Colors.green, colorText: Colors.white);
          }else{
            Get.snackbar('Hata', value,
                backgroundColor: Colors.green, colorText: Colors.white);
          }
        });
      },
      child: Container(
        width: Get.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 3)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/google_icon.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'Sign In With Google',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField phoneInput() {
    return TextFormField(
      controller: phoneController,
      validator: (value) {
        if (value!.length < 9) {
          return 'En az 9 karakter giriniz';
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Phone Number',
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }

  SizedBox registerButton(AuthProvider authProvider, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (isEmail) {
              authProvider
                  .registerWithEmail(emailController.text,
                      passwordController.text, nameController.text)
                  .then((value) async {
                if (value != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(value),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  Get.to(() => const Login());
                }
              });
            } else {
              authProvider.registerWithPhoneNumber(
                  phoneController.text, nameController.text);
            }
          }
        },
        child: const Text(
          'Register',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  TextFormField passwordInput() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value!.length < 3) {
          return 'En az 3 karakter giriniz';
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: emailController,
      validator: (value) {
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!);
        if (!emailValid) {
          return 'Lütfen geçerli email giriniz';
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField nameInput() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value!.length < 3) {
          return 'En az 3 karakter giriniz';
        }
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Name',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
