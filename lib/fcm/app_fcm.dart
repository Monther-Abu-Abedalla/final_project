// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:consulting_app/feature/view/screens/account_status/account_status_screen.dart';
import 'package:consulting_app/feature/view/screens/home/post_details_screen.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppFcm {
  AppFcm._();
  static AppFcm fcmInstance = AppFcm._();
  init() {
    configuration();
    registerNotification();
    getTokenFCM();
  }

  static HomeViewModel homeViewModel =
      Get.put(HomeViewModel(), permanent: true);

  ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  MethodChannel platform =
      const MethodChannel('dexterx.dev/flutter_local_notifications_example');
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RemoteMessage messages = const RemoteMessage();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'com.consuliting.app', 'com.consuliting.app',
      importance: Importance.max,
      playSound: true,
      showBadge: true,
      enableLights: true,
      ledColor: Colors.red);

  configuration() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await selectNotification(
          notificationAppLaunchDetails?.notificationResponse?.payload);
    }
  }

  Future selectNotification(String? payload) async {
    try {
      // RemoteMessage message = messages;

      goToOrderPage(messages.data, remoteMessage: messages);
    } catch (e) {
      print(e);
      Logger().d(e);
    }
  }

  void registerNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //todo this for add badge for app
      // var android = message.data;
      Logger().e("MSG_NOT ${messages.data.toString()}");
      if (Platform.isIOS || Platform.isAndroid) {
        messages = message;
        updatePages(message, notification);
        showDefoultNotification(message: message, notification: notification);
      }
    });
  }

  getTokenFCM() async {
    await firebaseMessaging.getToken().then((token) async {
      Logger().d('token fcm : $token');
      await SharedPref.instance.setFCMToken(token.toString());
    }).catchError((err) {
      Logger().d(err);
    });
  }

  void updatePages(
      RemoteMessage message, RemoteNotification notification) async {
    try {
      var map = jsonDecode(message.data["data"]);
      if (Constance.instance.changeAccountStatusId ==
          map[Constance.instance.id]) {
        homeViewModel.getProfile();
      } else if (map[Constance.instance.id] == Constance.instance.newComment) {
        homeViewModel.getPostById(
            id: map[Constance.instance.postId], isFromNotification: true);
      } else if (map[Constance.instance.id] ==
          Constance.instance.postAddedToMe) {
        homeViewModel.getHomePosts();
      } else if (map[Constance.instance.id] == Constance.instance.needPayment) {
        homeViewModel.getConsultationSubscription(
            postId: map[Constance.instance.postId]);
      } else if (map[Constance.instance.id] ==
          Constance.instance.successPayment) {
        Get.offAll(PostDetailsScreen(
          isFromNotification: true,
          postId: map[Constance.instance.postId],
        ));
      } else if (map[Constance.instance.id] ==
          Constance.instance.requestShare) {
        homeViewModel.showShareBottomSheet(
            body: notification.body ?? "",
            shareRequestId: map[Constance.instance.shareRequsetId]);
      }
    } catch (e) {
      Logger().e("updatePages $e");
    }
  }

  static void goToOrderPage(Map<String, dynamic> map,
      {required RemoteMessage remoteMessage}) {
    try {
      map = jsonDecode(map["data"].toString());
      Logger().d(map);

      if (Constance.instance.changeAccountStatusId ==
          map[Constance.instance.id]) {
        homeViewModel.getProfile();
        Get.off(() => const AccountStatusScreen(
              isFromNotification: true,
            ));
      } else if (Constance.instance.postAddedToMe ==
          map[Constance.instance.id]) {
        Get.offAll(PostDetailsScreen(
          isFromNotification: true,
          postId: map[Constance.instance.postId],
        ));
      } else if (Constance.instance.newComment == map[Constance.instance.id]) {
        Get.offAll(PostDetailsScreen(
          isFromNotification: true,
          postId: map[Constance.instance.postId],
        ));
      } else if (Constance.instance.needPayment == map[Constance.instance.id]) {
        Get.offAll(PostDetailsScreen(
          isFromNotification: true,
          postId: map[Constance.instance.postId],
        ));
        homeViewModel.getConsultationSubscription(
            postId: map[Constance.instance.postId]);
      } else if (Constance.instance.id ==
          map[Constance.instance.successPayment]) {
        Get.offAll(PostDetailsScreen(
          isFromNotification: true,
          postId: map[Constance.instance.postId],
        ));

        homeViewModel.getPostById(
            id: map[Constance.instance.postId], isFromNotification: true);
      } else if (map[Constance.instance.id] ==
          Constance.instance.requestShare) {
        homeViewModel.showShareBottomSheet(
            body: remoteMessage.notification?.title ?? "",
            shareRequestId:
                remoteMessage.data[Constance.instance.shareRequsetId]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> _showBigPictureNotification() async {
  //   final String largeIconPath = await _downloadAndSaveFile(
  //       'https://via.placeholder.com/48x48', 'largeIcon');
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       'https://via.placeholder.com/400x800', 'bigPicture');
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
  //           largeIcon: FilePathAndroidBitmap(largeIconPath),
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           channelShowBadge: true,
  //           priority: Priority.max,
  //           showWhen: false,
  //           enableVibration: true,
  //           importance: Importance.max,
  //           icon: "drawable/app_icon",
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'big text title', 'silent body', platformChannelSpecifics);
  // }

  // Future<String> _downloadAndSaveFile(String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final http.Response response = await http.get(Uri.parse(url));
  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }

  // Future<void> _showBigPictureNotificationURL() async {
  //   final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
  //       await _getByteArrayFromUrl('https://via.placeholder.com/48x48'));
  //   final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
  //       await _getByteArrayFromUrl('https://via.placeholder.com/400x800'));
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(bigPicture,
  //           largeIcon: largeIcon,
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           //sound: 'slow_spring_board',
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'big text title', 'silent body', platformChannelSpecifics);
  // }

  // Future<Uint8List> _getByteArrayFromUrl(String url) async {
  //   final http.Response response = await http.get(Uri.parse(url));
  //   return response.bodyBytes;
  // }

  showDefoultNotification(
      {required RemoteNotification notification,
      required RemoteMessage message}) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id, channel.name,
            // channel.description,
            enableLights: true,
            enableVibration: true,
            fullScreenIntent: true,
            autoCancel: true,
            importance: Importance.max,
            priority: Priority.max,
          ),
        ),
        payload: "${message.data}");
  }
}
