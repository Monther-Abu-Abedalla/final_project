import 'dart:convert';

import 'package:consulting_app/feature/model/auth/topic_model.dart';
import 'package:consulting_app/network/api/model/app_response.dart';
import 'package:consulting_app/network/api/model/auth.dart';
import 'package:consulting_app/network/utils/constance_network.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:logger/logger.dart';

class AuthHelper {
  AuthHelper._();
  static final AuthHelper getInstance = AuthHelper._();
  Logger log = Logger();

  Future<AppResponse> loginUser(var body) async {
    var appResponse = await AuthApi.getInstance.loginRequest(
        body: body,
        url: ConstanceNetwork.loginEndPoint,
        header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
      SharedPref.instance.setCurrentUserData(user: jsonEncode(appResponse.data));
      SharedPref.instance.setUserToken(token: appResponse.data["token"]);
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> registerUser(Map<String, dynamic> body) async {
    var appResponse = await AuthApi.getInstance.registerRequest(
        body: body,
        url: ConstanceNetwork.registerEndPoint,
        header: ConstanceNetwork.header(0));
    if (appResponse.status?.success == true) {
      SharedPref.instance
          .setCurrentUserData(user: jsonEncode(appResponse.data));
      SharedPref.instance.setUserToken(token: appResponse.data["token"]);
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> sendCertificate(Map<String, dynamic> body) async {
    var appResponse = await AuthApi.getInstance.sendCertificate(
        body: body,
        url: ConstanceNetwork.sendCertificateEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> sendTopics(Map<String, dynamic> body) async {
    var appResponse = await AuthApi.getInstance.sendTopics(
        body: body,
        url: ConstanceNetwork.sendTopicsEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<List<Topic>> getTopics() async {
    var appResponse = await AuthApi.getInstance.getTopics(
      url: ConstanceNetwork.topicEndPoint,
      header: ConstanceNetwork.header(4),
    );
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Topic.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
