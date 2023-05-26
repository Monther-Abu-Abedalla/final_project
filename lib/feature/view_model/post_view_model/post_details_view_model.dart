import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../network/api/feature/home_helper.dart';
import '../../../utils/constance/constance.dart';
import '../../../utils/shared/sh_util.dart';
import '../../../utils/util/utils.dart';
import '../../model/auth/topic_model.dart';
import '../../model/home/comment_model.dart';
import '../../model/home/post_model.dart';
import '../../model/home/subscription_model.dart';
import '../../view/screens/home/widgets/subscription/subscription_bottom_sheet.dart';

class PostDetailsViewModel extends ChangeNotifier {
  PostDetailsViewModel({required int postId}) {
    if (postId == -1) {
      return;
    }
    getPostById(id: postId, isFromNotification: false);
  }

  bool isLoading = false;
  bool isLoadingAddComment = false;

  bool isLoadingDelete = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
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

  bool isCanComment() {
    if (SharedPref.instance.getCurrentUserData()?.isApproved == false) {
      return false;
    }

    if (operationPost.receiverId == -1) {
      return true;
    } else if (operationPost.receiverId ==
        SharedPref.instance.getCurrentUserData()?.id) {
      return true;
    } else if (operationPost.makerId ==
        SharedPref.instance.getCurrentUserData()?.id) {
      return true;
    }

    return false;
  }

  bool isTopicInMyTopic() {
    List<Topic> topics = SharedPref.instance.getCurrentUserData()?.topics ?? [];
    for (var item in topics) {
      if (item.id == operationPost.topicId) {
        return true;
      }
    }
    return false;
  }

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
                  {
                    showBottomSheetSubscription(subscription: newSubscription),
                  }
              }
            else
              {Utils.instance.snackError(body: value.status?.message ?? "")}
          });
    } catch (e) {
      printError();
    }
  }

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

  Future<void> deletePost({required int postId}) async {}

  Future<void> onAddNewComment() async {
    if (tdComment.text.trim().isNotEmpty) {
      await addComment(
        newComment: Comment(
          postId: operationPost.id,
          content: tdComment.text,
          makerViewingType: 1,
          makerId: SharedPref.instance.getCurrentUserData()?.id,
          makerName: SharedPref.instance.getCurrentUserData()?.username,
        ),
      );
      tdComment.text = "";
    }
  }
}
