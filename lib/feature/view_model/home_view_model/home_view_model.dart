import 'dart:async';
import 'package:consulting_app/feature/view/screens/home/widgets/incrases_time_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final commentsController = ScrollController();

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

  List notifications = [];

  TextEditingController tdSelectedTopic = TextEditingController();
  void startLoading() {
    isLoading = true;
    update();
  }

  void endLoading() {
    isLoading = false;
    update();
  }

  void startLoadingProfile() {
    isLoadingProfile = true;
    update();
  }

  void endLoadingProfile() {
    isLoadingProfile = false;
    update();
  }

  void startLoadingAddComment() {
    isLoadingAddComment = true;
    update();
  }

  void endLoadingAddComment() {
    isLoadingAddComment = false;
    update();
  }

  void startLoadingFav() {
    isLoadingFav = true;
    update();
  }

  void endLoadingFav() {
    isLoadingFav = false;
    update();
  }

  void startDeleteLoading() {
    isLoadingDelete = true;
    update();
  }

  void endDeleteLoading() {
    isLoadingDelete = false;
    update();
  }

  void startLosingSharePost() {
    isLoadingSharePost = true;
    update();
  }

  void endLosingSharePos() {
    isLoadingSharePost = false;
    update();
  }

  // todo here we need to add the post to the server
  final tdTitle = TextEditingController();
  final tdContent = TextEditingController();

  final tdComment = TextEditingController();

  Future<void> showIncreaseTime() async {
    try {
      Get.bottomSheet(const IncreaseTimeBottomSheet(),
          isScrollControlled: true);
    } catch (e) {
      printError();
    }
  }

  final tdTime = TextEditingController();
  final tdPrice = TextEditingController();
}
