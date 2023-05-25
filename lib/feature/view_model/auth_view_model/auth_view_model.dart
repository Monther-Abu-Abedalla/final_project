import 'dart:convert';
import 'dart:io';

import 'package:consulting_app/feature/model/auth/user_model.dart';
import 'package:consulting_app/feature/view/screens/home/home_screen.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:dio/dio.dart' as multi_part;
import 'package:consulting_app/feature/model/auth/topic_model.dart';
import 'package:consulting_app/feature/view/screens/auth/choose_topics_screen.dart';
import 'package:consulting_app/network/api/feature/auth_helper.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:consulting_app/utils/util/utils.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../view/screens/auth/add_certificate_screen.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel() {
    getDeviceDetails();
  }

  final tdNameRegister = TextEditingController();
  final tdEmailRegister = TextEditingController();
  final tdPasswordRegister = TextEditingController();

  final tdPassword = TextEditingController();
  final tdEmail = TextEditingController();

  String identifier = "";
  // to do for Loading

  List<Topic> topics = [];
  Set<Topic> selectedTopics = {};
  List<File> certificatesImages = [];

  void addNewTopic({required Topic topic}) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> sendTopics() async {
    List<int> topicsIds = [];
    for (var item in selectedTopics) {
      topicsIds.add(item.id ?? 0);
    }
    try {
      await AuthHelper.getInstance.sendTopics({
        "topicsIds": jsonEncode(topicsIds),
      }).then((value) => {
            Logger().e(value),
          });
    } catch (e) {
      printError();
    }
  }

  void startLoading() {
    isLoading = true;

    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> signUp({required UserModel user}) async {
    try {
      startLoading();
      await AuthHelper.getInstance.registerUser(user.toJson()).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
                SharedPref.instance.setUserLoginState(
                    value: Constance.instance.chooseTopicsState),
                getTopics(),
                Get.off(() => const ChooseTopicsScreen())
              }
            else
              {
                Utils.instance.snackError(body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> signIn({required UserModel user}) async {
    try {
      startLoading();
      await AuthHelper.getInstance.loginUser(user.toJson()).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
                Get.put(HomeViewModel(), permanent: true),
                Get.off(() => const HomeScreen()),
                SharedPref.instance.setUserLoginState(
                    value: Constance.instance.userLoggedState),
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? "")
              }
          });
    } catch (e) {
      printError();
    }
    endLoading();
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
      notifyListeners();
    } on PlatformException {
      Logger().e("PlatformException");
    }
    return [identifier];
  }

  Future<void> getTopics() async {
    try {
      await AuthHelper.getInstance
          .getTopics()
          .then((value) => {topics = value});
    } catch (e) {
      printError();
    }
    notifyListeners();
  }

  final picker = ImagePicker();

  Future getImage() async {
    final List<XFile> images = await picker.pickMultiImage(
      imageQuality: 50,
    );
    for (var item in images) {
      certificatesImages.add(File(item.path));
      notifyListeners();
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

    notifyListeners();
  }

  Future<void> getAvailableBiometrics() async {
    try {
      await authLocal.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      startLoading();
      authenticated = await authLocal.authenticate(
        localizedReason: 'ادخل بصمتك لتسجيل الدخول',
        // useErrorDialogs: true,
        // biometricOnly: true,
        // stickyAuth: false,
      );
      await signIn(
          user: UserModel(
        email: SharedPref.instance.getCurrentUserData()?.email,
        password: SharedPref.instance.getCurrentUserData()?.password ??
            SharedPref.instance.getCurrentUserData()?.socialId,
        type: SharedPref.instance.getUserType(),
        fcm: SharedPref.instance.getFCMToken(),
        deviceId: identifier,
      ));
    } on PlatformException catch (e) {
      print(e);
    }
    isAuth = authenticated ? true : false;
    endLoading();
    notifyListeners();
  }

  Future<void> sendCertificate() async {
    startLoading();
    try {
      if (certificatesImages.isEmpty) {
        return;
      }
      List sendedData = [];
      for (var item in certificatesImages) {
        // item = await Utils.instance.compressImage(item);
        sendedData.add(multi_part.MultipartFile.fromFileSync(item.path));
      }

      await AuthHelper.getInstance
          .sendCertificate({"certificates[]": sendedData}).then((value) => {
                if (value.status!.success!)
                  {
                    Utils.instance
                        .snackSuccess(title: "", body: value.status!.message!),
                    Get.offAll(() => const HomeScreen()),
                    Get.put(HomeViewModel(), permanent: true),
                    SharedPref.instance.setUserLoginState(
                        value: Constance.instance.userLoggedState)
                  }
                else
                  {
                    Utils.instance
                        .snackError(title: "", body: value.status!.message!)
                  }
              });
    } catch (e) {
      printError();
    }

    endLoading();
  }

  //this for Touch/face (Id) Bottom Sheet :
  logInWithTouchId() async {
    try {
      startLoading();
      await checkBiometrics();
      await getAvailableBiometrics();
      await authenticate();
      await signIn(
          user: UserModel(
              email: SharedPref.instance.getCurrentUserData()?.email,
              password: SharedPref.instance.getCurrentUserData()?.password));
    } catch (e) {
      printError();
    }
    endLoading();
  }

  // creating firebase instance

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signupWithGoogle({required bool isLogin}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await auth.signInWithCredential(authCredential);
      //  User user = result.user;
      Logger().i(result.user);
      if (!GetUtils.isNull(result)) {
        if (isLogin) {
          await signIn(
              user: UserModel(
                  // username: result.user?.displayName,
                  email: result.user?.email,
                  password: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  //  type: SharedPref.instance.getUserType(),
                  deviceId: identifier));
        } else {
          await signUp(
              user: UserModel(
                  username: result.user?.displayName,
                  email: result.user?.email,
                  //password: result.user?.uid,
                  socialId: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  type: SharedPref.instance.getUserType(),
                  deviceId: identifier));
        }
        // Navigator.pushReplacement(
        //     Get.context!,
        //     MaterialPageRoute(
        //         builder: (context) => const ChooseTopicsScreen()));
      }
    }
  }

  Future<void> signInWithFacebook({required bool isLogin}) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential result = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      if (!GetUtils.isNull(result)) {
        if (isLogin) {
          await signIn(
              user: UserModel(
                  email: result.user?.email,
                  password: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  deviceId: identifier));
        } else {
          await signUp(
              user: UserModel(
                  username: result.user?.displayName,
                  email: result.user?.email,
                  // password: result.user?.uid,
                  socialId: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  type: SharedPref.instance.getUserType(),
                  deviceId: identifier));
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signInWithTwitter({required bool isLogin}) async {
    try {
      TwitterLogin twitterLogin = TwitterLogin(
        apiKey: "mt7hscQv3i52npit0Z7ZG1DHg",
        apiSecretKey: "zaQ79z1djOYnNkratUExKxYKyrEY4bduchXr2KT9OjziAQ0J1r",
        redirectURI: "consuliting://",
      );

      // Trigger the sign-in flow
      final authResult = await twitterLogin.loginV2();

      // Create a credential from the access token
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      final result = await FirebaseAuth.instance
          .signInWithCredential(twitterAuthCredential);

      if (!GetUtils.isNull(result)) {
        if (isLogin) {
          await signIn(
              user: UserModel(
                  email: result.user?.email,
                  password: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  deviceId: identifier));
        } else {
          await signUp(
              user: UserModel(
                  username: result.user?.displayName,
                  email: result.user?.email,
                  socialId: result.user?.uid,
                  fcm: SharedPref.instance.getFCMToken(),
                  type: SharedPref.instance.getUserType(),
                  deviceId: identifier));
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  void onClickStart() {
    sendTopics();
    if (SharedPref.instance.getUserType() == Constance.instance.consultantUserType) {
      Get.put(AuthViewModel(), permanent: true);
      Get.to(() => const AddCertificateScreen());
    } else {
      Get.offAll(() => const HomeScreen());
      Get.put(HomeViewModel(), permanent: true);
      SharedPref.instance
          .setUserLoginState(value: Constance.instance.userLoggedState);
    }
  }
}
