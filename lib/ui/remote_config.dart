import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemoteConfigPage extends StatefulWidget {
  const RemoteConfigPage({Key? key}) : super(key: key);

  @override
  _RemoteConfigPageState createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {

  @override
  void initState() {
    super.initState();
    setupRemoteConfig();
  }



  void setupRemoteConfig() async {
    RemoteConfig remoteConfig = RemoteConfig.instance;
    await remoteConfig.ensureInitialized();
    await remoteConfig.fetchAndActivate();
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(milliseconds: 1),
      ),
    );
    var result = remoteConfig.getBool('isUpdate');
    print(remoteConfig.getString('title'));
    if (result == true) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Güncelleme',
        message: 'Güncelleme var ve zorunlu',
        duration: Duration(seconds: 1),
      ));
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: 'Güncelleme',
        message: 'Güncelleme var ve zorunlu değil',
        duration: Duration(seconds: 1),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
