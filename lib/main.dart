import 'package:consulting_app/feature/core/app_widget.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/feature/view_model/post_view_model/post_details_view_model.dart';
import 'package:consulting_app/utils/deep_link/deep_link_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fcm/app_fcm.dart';
import 'network/api/dio_manager/dio_manage_class.dart';
import 'utils/shared/sh_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.init();
  await Firebase.initializeApp();
  await AppFcm.fcmInstance.init();
  DioManagerClass.getInstance.init();
  await DeepLinkService.instance.initLinks();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => PostDetailsViewModel(postId: -1)),
    ],
    child: const AppWidget(),
  ));
}
