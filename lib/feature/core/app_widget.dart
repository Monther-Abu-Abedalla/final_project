import 'package:consulting_app/fcm/app_fcm.dart';
import 'package:consulting_app/feature/core/theme/main_theme/app_theme.dart';
import 'package:consulting_app/feature/view/screens/splash/splash_screen.dart';
import 'package:consulting_app/utils/localization/localization_service.dart';
import 'package:consulting_app/utils/shared/dynamic_link_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../main.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
 
 Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      Logger().d("remote message $initialMessage");
      _handleMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("MSG_BUG _handleMessage");
    AppFcm.goToOrderPage(message.data, remoteMessage: message);
  }

  @override
  void initState() {
    super.initState();
    DynamicLinkService().retrieveDynamicLink(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupInteractedMessage();
    });
  }

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      title: "consuliting app",
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'us'),
      fallbackLocale: LocalizationService.fallbackLocale,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      translations: LocalizationService(),
      theme: AppTheme.instance.materialLightTheme,
      initialBinding: Bind(),
    );
  }
}
