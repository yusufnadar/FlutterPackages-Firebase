import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase/provider/user_provider.dart';
import 'package:firebase/ui/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = TextEditingController();

  final imagePicker = ImagePicker();
  File? file;

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const EditProfile());
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  file == null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(
                            _userProvider.user.profilePhoto!,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(file!),
                          radius: 60,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                                title: const Text('Galeriden Seç'),
                              ),
                              ListTile(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                                title: const Text('Kameradan Çek'),
                              ),
                            ],
                          ),
                        );
                        //
                      },
                      child: const CircleAvatar(
                        radius: 18,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _userProvider.user.name!.capitalize!,
                style: const TextStyle(fontSize: 26),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage(ImageSource source) async {
    final _userProvider = Provider.of<UserProvider>(context,listen: false);
    var photo = await imagePicker.pickImage(source: source);
    if (photo != null) {
      setState(() {
        file = File(photo.path);
      });
      _userProvider.updateProfilePhoto(file,_userProvider.user.id);
      Get.back();
    }
  }
}
