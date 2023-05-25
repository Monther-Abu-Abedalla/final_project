import 'dart:async';

import 'package:consulting_app/feature/model/app/common_questions_model.dart';
import 'package:consulting_app/feature/model/auth/topic_model.dart';
import 'package:consulting_app/feature/model/home/comment_model.dart';
import 'package:consulting_app/feature/model/home/post_model.dart';
import 'package:consulting_app/feature/model/home/subscription_model.dart';
import 'package:consulting_app/feature/model/home/topic_consultants_model.dart';
import 'package:consulting_app/feature/view/screens/auth/login_screen.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/add_post/choose_topics_bottom_sheet.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/incrases_time_bottom_sheet.dart';
import 'package:consulting_app/network/api/feature/home_helper.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:consulting_app/utils/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../model/home/notification_model.dart';
import '../../view/screens/home/widgets/subscription/subscription_bottom_sheet.dart';
import '../../view/widget/share_bottom_sheet.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getProfile();
    refreshHome();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final commentsController = ScrollController();

  int minutes = 0;

  int seconds = 0;

  int sharePostId = -1;

  logOut() {
    try {
      Get.defaultDialog(
          title: "",
          content: const Text("هل انت متأكد بانك تريد تسجيل الخروج ؟"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.offAll(() => LoginScreen());
                  SharedPref.instance.setUserLoginState(
                      value: Constance.instance.userEnterdState);
                },
                child: const Text("نعم")),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("لا")),
          ]);
    } catch (e) {
      printError();
    }
  }

  bool isLoading = false;
  bool isLoadingAddComment = false;
  bool isLoadingFav = false;
  bool isLoadingDelete = false;
  bool isLoadingProfile = false;
  bool isLoadingSharePost = false;

  String privacyPolicy = "";
  String appSummary = "";
  bool isName = false;
  bool isPublic = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void startLoadingProfile() {
    isLoadingProfile = true;
    notifyListeners();
  }

  void endLoadingProfile() {
    isLoadingProfile = false;
    notifyListeners();
  }

  void startLoadingAddComment() {
    isLoadingAddComment = true;
    notifyListeners();
  }

  void endLoadingAddComment() {
    isLoadingAddComment = false;
    notifyListeners();
  }

  void startLoadingFav() {
    isLoadingFav = true;
    notifyListeners();
  }

  void endLoadingFav() {
    isLoadingFav = false;
    notifyListeners();
  }

  void startDeleteLoading() {
    isLoadingDelete = true;
    notifyListeners();
  }

  void endDeleteLoading() {
    isLoadingDelete = false;
    notifyListeners();
  }

  void startLosingSharePost() {
    isLoadingSharePost = true;
    notifyListeners();
  }

  void endLosingSharePos() {
    isLoadingSharePost = false;
    notifyListeners();
  }

  Future<void> getPrivacy() async {
    startLoading();
    try {
      await HomeHelper.getInstance
          .getPrivacyPolicy()
          .then((value) => {privacyPolicy = value.data["privacyPolicy"]});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> getAppSummary() async {
    startLoading();
    try {
      await HomeHelper.getInstance
          .getAppSummary()
          .then((value) => {appSummary = value.data["appSummary"]});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> getProfile() async {
    startLoadingProfile();
    try {
      await HomeHelper.getInstance.getProfile();
    } catch (e) {
      printError();
    }
    endLoadingProfile();
  }

  Topic? selectedTopic;
  final tdSelectedTopic = TextEditingController();

  Future<void> showChooseTopicTypeBottomSheet() async {
    Get.bottomSheet(
      const ChooseTopicsBottomSheet(),
      isScrollControlled: true,
    );
  }

  // todo here we need to add the post to the server
  final tdTitle = TextEditingController();
  final tdContent = TextEditingController();

  Set<Post> homePosts = {};

  cleanPostForm() {
    tdContent.clear();
    tdTitle.clear();
    tdSelectedTopic.clear();
    isPublic = false;
    isName = false;
    selectedTopic = null;
  }

  Future<void> createNewPost({required Post post}) async {
    List<Post> data = [];
    startLoading();
    try {
      await HomeHelper.getInstance
          .createPost(body: post.toJson())
          .then((value) => {
                if (value.status!.success!)
                  {
                    Get.back(),
                    Utils.instance.snackSuccess(
                        title: "", body: value.status?.message ?? ""),
                    data.add(Post.fromJson(value.data)),
                    data.addAll(homePosts),
                    homePosts = data.toSet(),
                    cleanPostForm()
                  }
                else
                  {
                    Utils.instance.snackError(
                        title: "", body: value.status?.message ?? "")
                  }
              });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  List<TopicConsultants> topicConsultants = [];

  Future<void> getConsultingTopics({required int topicId}) async {
    topicConsultants.clear();
    startLoading();
    try {
      await HomeHelper.getInstance
          .getConsultantsByTopics(body: {"topicId": topicId}).then((value) => {
                topicConsultants = value,
              });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> getHomePosts() async {
    startLoading();
    try {
      await HomeHelper.getInstance
          .getHomePosts()
          .then((value) => {homePosts = value.toSet()});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> refreshHome() async {
    try {
      await getHomePosts();
    } catch (e) {
      printError();
    }
  }

  final tdComment = TextEditingController();

  Future<void> addComment({required Comment newComment}) async {
    startLoadingAddComment();
    try {
      await HomeHelper.getInstance
          .addComment(body: newComment.toJson())
          .then((value) => {
                if (value.status!.success!)
                  {
                    if (tdComment.text.isNotEmpty)
                      {
                        operationPost.comments?.add(Comment(
                            postId: operationPost.id,
                            content: tdComment.text,
                            makerViewingType: 1,
                            makerName: SharedPref.instance
                                .getCurrentUserData()
                                ?.username,
                            makerId:
                                SharedPref.instance.getCurrentUserData()?.id)),
                      },
                    Utils.instance.snackSuccess(
                        title: "", body: value.status?.message ?? ""),
                  }
                else
                  {
                    Utils.instance.snackError(
                        title: "", body: value.status?.message ?? "")
                  }
              });
    } catch (e) {
      printError();
    }
    endLoadingAddComment();
  }

  Post operationPost = Post();
  Future<void> getPostById(
      {required int id, required bool isFromNotification}) async {
    if (isFromNotification) {
      startLoadingAddComment();
    } else {
      startLoading();
    }

    try {
      await HomeHelper.getInstance.getPostDetails(body: {
        "postId": id,
      }).then((value) => {
            operationPost = Post.fromJson(value.data),
          });
    } catch (e) {
      printError();
    }
    if (isFromNotification) {
      endLoadingAddComment();
    } else {
      endLoading();
    }
  }

  List<CommonQuestion> commonQuestions = [];

  Future<void> getQuestions() async {
    startLoading();
    try {
      await HomeHelper.getInstance
          .getCommonQuestions()
          .then((value) => {commonQuestions = value});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  int favoritesPostId = -1;
  Future<void> addToFavorite({required int postId}) async {
    favoritesPostId = postId;
    startLoadingFav();
    try {
      await HomeHelper.getInstance.addToFavorites(body: {
        Constance.instance.postId: postId
      }).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
                homePosts.where((element) => element.id == postId),
                for (var item in homePosts)
                  {
                    if (item.id == postId) {item.isFavorite = true}
                  }
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endLoadingFav();
  }

  Future<void> removeFromFavorite({required int postId}) async {
    favoritesPostId = postId;
    startLoadingFav();
    try {
      await HomeHelper.getInstance.removeFromFavorites(body: {
        Constance.instance.postId: postId
      }).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
                homePosts.where((element) => element.id == postId),
                for (var item in homePosts)
                  {
                    if (item.id == postId) {item.isFavorite = false}
                  },
                favoritePosts
                    .removeWhere((element) => element.id == favoritesPostId)
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endLoadingFav();
  }

  Future<void> deletePost({required int postId}) async {
    startDeleteLoading();
    try {
      await HomeHelper.getInstance.deletePost(body: {
        Constance.instance.postId: postId
      }).then((value) => {
            if (value.status!.success!)
              {
                homePosts.removeWhere((element) => element.id == postId),
                myPosts.removeWhere((element) => element.id == postId),
                Get.back(),
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endDeleteLoading();
  }

  Set<Post> myPosts = {};
  Set<Post> favoritePosts = {};

  Future<void> getMyPosts() async {
    startLoading();
    try {
      await HomeHelper.getInstance
          .getMyPosts()
          .then((value) => {myPosts = value.toSet()});
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> getFavoritePosts() async {
    startLoading();
    try {
      await HomeHelper.getInstance.getFavoritePosts().then((value) => {
            favoritePosts = value.toSet(),
          });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> showIncreaseTime() async {
    try {
      Get.bottomSheet(const IncreaseTimeBottomSheet(),
          isScrollControlled: true);
    } catch (e) {
      printError();
    }
  }

  // After User Payment ::
  Future<void> increaseTime({required int postId, required num time}) async {
    startLoading();
    try {
      HomeHelper.getInstance.increaseTime(body: {
        Constance.instance.postId: postId,
        Constance.instance.extraTime: time
      }).then((value) => {
            if (value.status!.success!)
              {
                Get.back(),
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
                // operationPost.expiresAt = value.data,
                //  operationPost = Post.fromJson(value.data),
                getPostById(id: postId, isFromNotification: true),
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  final tdTime = TextEditingController();
  final tdPrice = TextEditingController();

  Future<void> getConsultationSubscription({required int postId}) async {
    Subscription newSubscription = Subscription();
    try {
      await HomeHelper.getInstance.getConsultationSubscription(body: {
        Constance.instance.postId: postId,
      }).then((value) => {
            if (value.status!.success!)
              {
                // Utils.instance.snackSuccess(body: value.status?.message ?? ""),
                newSubscription = Subscription.fromJson(value.data),
                if (newSubscription.postId != null)
                  {showBottomSheetSubscription(subscription: newSubscription)}
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      printError();
    }
  }

  // Before User Payment ::
  Future<void> addConsultationSubscription({required int postId}) async {
    startLoading();
    try {
      await HomeHelper.getInstance.addConsultationSubscription(body: {
        Constance.instance.postId: postId,
        Constance.instance.extraTimePrice:
            num.tryParse(tdPrice.text.toString()),
        Constance.instance.extraTime:
            Duration(minutes: int.tryParse(tdTime.text.toString()) ?? 0)
                .inMilliseconds,
      }).then((value) => {
            if (value.status!.success!)
              {
                Get.back(),
                Utils.instance
                    .snackSuccess(title: "", body: value.status?.message ?? ""),
                Logger().e(value),
              }
            else
              {
                Utils.instance
                    .snackError(title: "", body: value.status?.message ?? ""),
              }
          });
    } catch (e) {
      printError();
    }
    endLoading();
  }

  Future<void> showShareBottomSheet(
      {required String body, required int shareRequestId}) async {
    Get.bottomSheet(
      ShowBottomSheet(
        body: body,
        shareRequestId: shareRequestId,
      ),
      isScrollControlled: true,
    );
  }

  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  // Future<void> createDynamicLink(bool short) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://reactnativefirebase.page.link',
  //     longDynamicLink: Uri.parse(
  //       'https://consuliting.page.link/Tbeh',
  //     ),
  //     link: Uri.parse(DynamicLink),
  //     androidParameters: const AndroidParameters(
  //       packageName: 'io.flutter.plugins.firebase.dynamiclinksexample',
  //       minimumVersion: 0,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: 'io.invertase.testing',
  //       minimumVersion: '0',
  //     ),
  //   );

  //   Uri url;
  //   if (short) {
  //     final ShortDynamicLink shortLink =
  //         await dynamicLinks.buildShortLink(parameters);
  //     url = shortLink.shortUrl;
  //   } else {
  //     url = await dynamicLinks.buildLink(parameters);
  //   }
  //   Logger().e(url);
  // }

  // final String DynamicLink = 'https://test-app/helloworld';
  // final String Link = 'https://reactnativefirebase.page.link/bFkn';

  // Future<void> initDynamicLinks() async {
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     Logger().e("message");
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }

  Future<void> showBottomSheetSubscription(
      {required Subscription subscription}) async {
    try {
      Get.bottomSheet(
        SubscriptionBottomSheet(
          subscription: subscription,
        ),
        isScrollControlled: true,
      );
    } catch (e) {
      printError();
    }
  }

  void makePayment({required Subscription subscription}) async {
    // List<PaymentItem> items = [PaymentItem(name: "T-Shirt", price: 2.98)];
    // FlutterPay flutterPay = FlutterPay();
    // flutterPay.setEnvironment(environment: PaymentEnvironment.Test );
    // Future<String> response = flutterPay.requestPayment(
    //   allowedPaymentNetworks: [
    //     PaymentNetwork.visa,
    //     PaymentNetwork.masterCard,
    //   ],

    //   googleParameters: GoogleParameters(
    //     gatewayName: "example",
    //     gatewayMerchantId: "example_id",
    //   ),
    //   appleParameters: AppleParameters(merchantIdentifier: "merchant.flutterpay.example"),
    //   currencyCode: "USD",
    //   countryCode: "US",
    //   paymentItems: items,
    // );

    increaseTime(
      postId: operationPost.id ?? -1,
      time: subscription.exteaTime ?? 0,
    );
  }

  Future<void> shareRequest(
      {required int postId,
      required String title,
      required GlobalKey<State<StatefulWidget>> key}) async {
    sharePostId = postId;
    startLosingSharePost();
    try {
      await HomeHelper.getInstance.shareRequest(body: {
        Constance.instance.postId: postId,
      }).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
                if (value.data["status"] == 2)
                  {
                    // DynamicLinkService().createDynamicLink(title: title),
                    // captureSocialPng(key: key)
                  }
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in shareRequest $e");
    }
    endLosingSharePos();
  }

  Future<void> onClickShare(
      {required Post post, required GlobalKey key}) async {
    if (post.receiverId != -1 &&
        post.makerId != SharedPref.instance.getCurrentUserData()?.id) {
      await shareRequest(
          postId: post.id ?? -1, title: post.title ?? "", key: key);
    } else {}
  }

  Future<void> updateShareRequestNotification(
      {required int shareRequestId, required int status}) async {
    if (status == 2) {
      startLosingSharePost();
    } else {
      startDeleteLoading();
    }

    try {
      await HomeHelper.getInstance.updateShareRequest(body: {
        "shareRequestId": shareRequestId,
        "status": status
      }).then((value) => {
            if (value.status!.success!)
              {Utils.instance.snackSuccess(body: value.status?.message ?? "")}
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in shareRequest $e");
    }
    if (status == 2) {
      endLosingSharePos();
    } else {
      endDeleteLoading();
    }
  }

  List<NotificationModel> notifications = [];

  Future<void> getNotifications() async {
    // try {
    startLoading();
    await HomeHelper.getInstance.getNotifications().then((value) => {
          notifications = value,
          notifyListeners(),
        });
    // } catch (e) {
    //   endLoading();
    //   Logger().e("Error in getNotifications $e");
    // }
    endLoading();
  }

  Future<void> reportPost({required int postId}) async {
    try {
      await HomeHelper.getInstance.reportPost(body: {
        Constance.instance.postId: postId,
      }).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in reportPost $e");
    }
  }

  Future<void> blockUser({required int userId}) async {
    try {
      await HomeHelper.getInstance.blockUser(
        body: {
          "user_id": userId,
        },
      ).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in blockUser $e");
    }
  }

  Future<void> reportComment({required int commentId}) async {
    try {
      await HomeHelper.getInstance.blockUser(
        body: {
          "comment_id": commentId,
        },
      ).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in blockUser $e");
    }
  }

  //get block users
  List blockUsers = [];

  //get block users request
  Future<void> getBlockUsers() async {
    try {
      startLoading();
      await HomeHelper.getInstance.getBlockUsers().then((value) => {
            blockUsers = value,
            notifyListeners(),
          });
    } catch (e) {
      endLoading();
      Logger().e("Error in getBlockUsers $e");
    }
    endLoading();
  }

  //unblock user
  Future<void> unBlockUser({required int userId}) async {
    try {
      await HomeHelper.getInstance.unBlockUser(
        body: {
          "user_id": userId,
        },
      ).then((value) => {
            if (value.status!.success!)
              {
                Utils.instance.snackSuccess(body: value.status?.message ?? ""),
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      Logger().e("Error in unBlockUser $e");
    }
  }

  void toggleIsPublic() {
    isPublic = !isPublic;
    notifyListeners();
  }

  void toggleIsName() {
    isName = !isName;
    notifyListeners();
  }

  void addTopic(Topic topic) {
    selectedTopic = topic;
    tdSelectedTopic.text = topic.name ?? "";
    getConsultingTopics(topicId: topic.id ?? 0);
    notifyListeners();
    Get.back();
  }
}
