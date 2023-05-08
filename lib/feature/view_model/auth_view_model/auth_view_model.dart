import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';

class AuthViewModel extends GetxController {
  final tdNameRegister = TextEditingController();
  final tdEmailRegister = TextEditingController();
  final tdPasswordRegister = TextEditingController();

  final tdPassword = TextEditingController();
  final tdEmail = TextEditingController();

  String identifier = "";
  // to do for Loading

  
  List<File> certificatesImages = [];

  

  bool isLoading = false;


  void startLoading() {
    isLoading = true;
    update();
  }

  void endLoading() {
    isLoading = false;
    update();
  }


  Future<List<String>> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        identifier = data.identifierForVendor; //UUID for iOS
      }
      update();
    } on PlatformException {
      Logger().e("PlatformException");
    }
    return [identifier];
  }


  final picker = ImagePicker();

  Future getImage() async {
    final List<XFile> images = await picker.pickMultiImage(
      imageQuality: 50,
    );
    for (var item in images) {
      certificatesImages.add(File(item.path));
      update();
    }
  }

  bool? isAuth = false;
  final LocalAuthentication authLocal = LocalAuthentication();

  Future<void> checkBiometrics() async {
    try {
      await authLocal.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    update();
  }

  Future<void> getAvailableBiometrics() async {
    try {
      await authLocal.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    update();
  }     


  //this for Touch/face (Id) Bottom Sheet :
  

  // creating firebase instance

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() async {
    super.onInit();
    getDeviceDetails();
  }
}