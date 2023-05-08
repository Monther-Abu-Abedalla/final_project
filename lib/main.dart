import 'package:consulting_app/feature/core/app_widget.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'fcm/app_fcm.dart';
import 'utils/shared/sh_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  await Firebase.initializeApp();
  await AppFcm.fcmInstance.init();
  runApp(const AppWidget());
}

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
  }
}