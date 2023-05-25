import 'dart:convert';

import 'package:consulting_app/feature/model/app/common_questions_model.dart';
import 'package:consulting_app/feature/model/home/notification_model.dart';
import 'package:consulting_app/feature/model/home/post_model.dart';
import 'package:consulting_app/feature/model/home/topic_consultants_model.dart';
import 'package:consulting_app/network/api/model/app_response.dart';
import 'package:consulting_app/network/api/model/home_model.dart';
import 'package:consulting_app/network/utils/constance_network.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:logger/logger.dart';

class HomeHelper {
  HomeHelper._();
  static final HomeHelper getInstance = HomeHelper._();
  Logger log = Logger();

  Future<AppResponse> getPrivacyPolicy() async {
    var appResponse = await HomeApi.getInstance.getPrivacyPolicy(
        url: ConstanceNetwork.getPrivacyPolicyEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> getAppSummary() async {
    var appResponse = await HomeApi.getInstance.getAppSummary(
        url: ConstanceNetwork.getAppSummaryEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> getProfile() async {
    var appResponse = await HomeApi.getInstance.getProfile(
        url: ConstanceNetwork.getAccountDataEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      SharedPref.instance
          .setCurrentUserData(user: jsonEncode(appResponse.data));
      SharedPref.instance.setAccountStatus(
          status: appResponse.status?.message ??
              Constance.instance.accountStatusPending);
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<AppResponse> createPost({var body}) async {
    var appResponse = await HomeApi.getInstance.createPost(
        url: ConstanceNetwork.createPostEndPoint,
        body: body,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      return appResponse;
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return appResponse;
    }
  }

  Future<List<TopicConsultants>> getConsultantsByTopics({var body}) async {
    var appResponse = await HomeApi.getInstance.getUserByTopics(
        url: ConstanceNetwork.getUserByTopicsEndPoint,
        body: body,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      List data = appResponse.data["topicConsultants"];
      return data.map((e) => TopicConsultants.fromJson(e)).toList();
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }

  Future<List<Post>> getHomePosts() async {
    var appResponse = await HomeApi.getInstance.getHome(
        url: ConstanceNetwork.getHomeEndPoints,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      List data = appResponse.data;
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }

  Future<AppResponse> addComment({var body}) async {
    var appResponse = await HomeApi.getInstance.addComment(
        body: body,
        url: ConstanceNetwork.createCommentEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getPostDetails({var body}) async {
    var appResponse = await HomeApi.getInstance.getPostDetails(
        body: body,
        url: ConstanceNetwork.getPostDetailedEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<List<CommonQuestion>> getCommonQuestions() async {
    var appResponse = await HomeApi.getInstance.getCommonQuestions(
        url: ConstanceNetwork.commonQuestionsEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      Logger().d("if ${appResponse.toJson()}");
      List data = appResponse.data;
      return data.map((e) => CommonQuestion.fromJson(e)).toList();
    } else {
      Logger().d("else ${appResponse.toJson()}");
      return [];
    }
  }

  Future<AppResponse> addToFavorites({var body}) async {
    var appResponse = await HomeApi.getInstance.addToFavorites(
        body: body,
        url: ConstanceNetwork.addToFavoritesEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> removeFromFavorites({var body}) async {
    var appResponse = await HomeApi.getInstance.addToFavorites(
        body: body,
        url: ConstanceNetwork.removeFromFavoritesEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> deletePost({var body}) async {
    var appResponse = await HomeApi.getInstance.deletePost(
        body: body,
        url: ConstanceNetwork.deletePostEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<List<Post>> getMyPosts() async {
    var appResponse = await HomeApi.getInstance.getMyPosts(
        url: ConstanceNetwork.getMyPostsEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Post>> getFavoritePosts() async {
    var appResponse = await HomeApi.getInstance.getMyPosts(
        url: ConstanceNetwork.getFavoritePostsEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data;
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<AppResponse> increaseTime({var body}) async {
    var appResponse = await HomeApi.getInstance.increaseTime(
        body: body,
        url: ConstanceNetwork.increaseTimeEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> addConsultationSubscription({var body}) async {
    var appResponse = await HomeApi.getInstance.increaseTime(
        body: body,
        url: ConstanceNetwork.addConsultationSubscriptionEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> getConsultationSubscription({var body}) async {
    var appResponse = await HomeApi.getInstance.getConsultationSubscription(
        body: body,
        url: ConstanceNetwork.getConsultationSubscriptionEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> shareRequest({var body}) async {
    var appResponse = await HomeApi.getInstance.shareRequest(
        body: body,
        url: ConstanceNetwork.sharePostEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<AppResponse> updateShareRequest({var body}) async {
    var appResponse = await HomeApi.getInstance.updateShareRequest(
        body: body,
        url: ConstanceNetwork.updateShareRequestEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    var appResponse = await HomeApi.getInstance.getNotifications(
        url: ConstanceNetwork.getNotificationsEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      List data = appResponse.data ?? [];
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<AppResponse> reportPost({required Map<String, int> body}) async {
    var appResponse = await HomeApi.getInstance.reportPost(
        body: body,
        url: ConstanceNetwork.reportPostEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

 Future<AppResponse> blockUser({required Map<dynamic, int> body}) async {
    var appResponse = await HomeApi.getInstance.blockUser(
        body: body,
        url: ConstanceNetwork.blockUserEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
 }

   Future<AppResponse> reportComment({required Map<String, int> body}) async {
    var appResponse = await HomeApi.getInstance.reportComment(
        body: body,
        url: ConstanceNetwork.repoCommentEndPoint,
        header: ConstanceNetwork.header(4));
    if (appResponse.status?.success == true) {
      return appResponse;
    } else {
      return appResponse;
    }
  }

  getBlockUsers() {}

  unBlockUser({required Map<String, int> body}) {}



  
}
