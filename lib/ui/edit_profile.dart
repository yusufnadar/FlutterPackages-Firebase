import 'package:firebase/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = Provider.of<UserProvider>(context,listen: false).user.name!;
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'Name',border: OutlineInputBorder()),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: Get.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _userProvider.updateUser(
                        controller.text, _userProvider.user.id!).then((value) => Get.back());
                  },
                  child: const Text('Update',style: TextStyle(fontSize: 18),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
