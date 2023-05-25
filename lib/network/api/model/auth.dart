import 'dart:convert';

import 'package:consulting_app/network/api/dio_manager/dio_manage_class.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'app_response.dart';

class AuthApi {
  AuthApi._();
  static final AuthApi getInstance = AuthApi._();
  //todo this is for login request

  Future<AppResponse> loginRequest({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, body: body, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);

      return AppResponse.fromJson(message);
    }
  }

  Future<AppResponse> registerRequest({var url, var header, var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, body: body, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);

      return AppResponse.fromJson(message);
    }
  }

    Future<AppResponse> getTopics({var url, var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioGetMethod(url: url, header: header);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
  
    Future<AppResponse> sendTopics({var url, var header , var body}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header , body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }


    Future<AppResponse> sendCertificate({var url, var body,var header}) async {
    try {
      var response = await DioManagerClass.getInstance
          .dioPostFormMethod(url: url, header: header , body: body);
      return AppResponse.fromJson(json.decode(response.toString()));
    } on DioError catch (ex) {
      var message = json.decode(ex.response.toString());
      Logger().e(message);
      return AppResponse.fromJson(message);
    }
  }
}
