// ignore_for_file: unused_field
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref instance = SharedPref._();
  SharedPref._();
  

  var log = Logger();

  static late SharedPreferences? _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  final String loginStateKey = "LoginKey";
  final String userTypeKey = "userTypeKey";
  final String userTokenKey = "tokenKey";
  final String userDataKey = "userDataKey";
  final String fcmKey = "fcmKey";
  final String accountStatus = "stausKet";

  void setUserLoginState({required String value}) {
    _prefs?.setString(loginStateKey, value);
  }

  String getUserLoginState() {
    try {
      return _prefs?.getString(loginStateKey) ?? "";
    } catch (e) {
      printError();
      return "";
    }
  }

  void setUserType({required String userType}) {
    _prefs?.setString(userTypeKey, userType);
  }

  String getUserType() {
    try {
      return _prefs?.getString(userTypeKey) ??
          Constance.instance.consultantUserType;
    } catch (e) {
      return Constance.instance.consultantUserType;
    }
  }

   void setAccountStatus({required String status}) {
    _prefs?.setString(accountStatus, status);
  }

  String getAccountStatus() {
    try {
      return _prefs?.getString(accountStatus) ??
          " ";
    } catch (e) {
      return Constance.instance.accountStatusPending;
    }
  }

  void setUserToken({required String token}) {
    _prefs?.setString(userTokenKey, token);
  }

  String getUserToken() {
    try {
      return _prefs?.getString(userTokenKey) ?? "";
    } catch (e) {
      printError();
      return "";
    }
  }

  void setCurrentUserData({required String user}) {
    _prefs?.setString(userDataKey, user);
  }

  // UserModel? getCurrentUserData() {
  //   try {
  //      String userString = _prefs?.getString(userDataKey) ?? "";
  //   return UserModel.fromJson(json.decode(userString));
  //   } catch (e) {
  //     return null;
  //   }
  // }

  setFCMToken(String fcmToken) async {
    try {
      _prefs?.setString(fcmKey, fcmToken);
    } catch (e) {
      printError();
    }
  }

  String getFCMToken() {
    return _prefs!.getString(fcmKey) ?? "";
  }
}
