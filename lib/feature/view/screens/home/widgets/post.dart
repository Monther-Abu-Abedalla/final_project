// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/model/home/post_model.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/report_block_popup_item.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/utils/date/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../utils/shared/sh_util.dart';
import '../../../widget/image_network.dart';
import '../post_details_screen.dart';

import 'dart:ui' as ui;

// ignore: must_be_immutable
class PostItem extends StatelessWidget {
  PostItem({Key? key, required this.post}) : super(key: key);

  final Post post;
  GlobalKey previewContainer = GlobalKey();
  static final HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorManger.instance.backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: ColorManger.instance.postBackgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CustomImageNetwork(
                      url: post.makerImageUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        post.makerName ?? "",
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Consumer<HomeViewModel>(
                    builder: (_, builder, __) {
                      if (builder.isLoadingFav &&
                          post.id == builder.favoritesPostId) {
                        return ThreeSizeDot(
                          color_1: ColorManger.instance.primaryColor,
                          color_2: ColorManger.instance.primaryColor,
                          color_3: ColorManger.instance.primaryColor,
                        );
                      }
                      return IconButton(
                          onPressed: () {
                            if (post.isFavorite ?? false) {
                              builder.removeFromFavorite(postId: post.id ?? 0);
                            } else {
                              builder.addToFavorite(postId: post.id ?? 0);
                            }
                          },
                          icon: post.isFavorite ?? false
                              ? SvgPicture.asset(
                                  "assets/svgs/star.svg",
                                )
                              : SvgPicture.asset("assets/svgs/favorite.svg"));
                    },
                  ),
                  Consumer<HomeViewModel>(
                    builder: (_, home, __) {
                      if (home.isLoadingSharePost &&
                          post.id == home.sharePostId) {
                        return ThreeSizeDot(
                          color_1: ColorManger.instance.primaryColor,
                          color_2: ColorManger.instance.primaryColor,
                          color_3: ColorManger.instance.primaryColor,
                        );
                      } else {
                        return IconButton(
                            onPressed: () async {
                              onClickShare(post: post, key: previewContainer);
                            },
                            icon: const Icon(Icons.share));
                      }
                    },
                  ),
                  ReportBlockPopupItem(
                    onReport: () {
                      homeViewModel.reportPost(postId: post.id ?? -1);
                    },
                    onBlock: () {
                      homeViewModel.blockUser(userId: post.makerId ?? -1);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Text(DateUtility.getChatTime(
                          DateTime.fromMillisecondsSinceEpoch(
                                  post.createdAt?.toInt() ?? 0)
                              .toString())
                      .toString()),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorManger.instance.backgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(post.content ?? ""),
              ),
              const SizedBox(
                height: 16,
              ),
              SeconderyButton(
                  height: 40,
                  textButton: "تفاصيل الاستشارة",
                  onClicked: () {
                    Get.to(() => PostDetailsScreen(
                          postId: post.id ?? -1,
                          isFromNotification: false,
                        ));
                  }),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onClickShare(
      {required Post post, required GlobalKey key}) async {
    if (post.makerId != SharedPref.instance.getCurrentUserData()?.id) {
      captureSocialPng();
      return;
    }
    if (post.receiverId != -1 &&
        post.makerId != SharedPref.instance.getCurrentUserData()?.id) {
      await homeViewModel.shareRequest(
          postId: post.id ?? -1, title: post.title ?? "", key: key);
    } else {
      captureSocialPng();
    }
  }

  Future<void> captureSocialPng() async {
    try {
      List<String> imagePaths = [];
      return Future.delayed(const Duration(milliseconds: 30), () async {
        RenderRepaintBoundary? boundary = previewContainer.currentContext!
            .findRenderObject() as RenderRepaintBoundary?;
        ui.Image image = await boundary!.toImage();
        final directory = (await getApplicationDocumentsDirectory()).path;
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        File imgFile = File('$directory/screenshot.png');
        imagePaths.add(imgFile.path);
        imgFile.writeAsBytes(pngBytes).then((value) async {
          await Share.shareFiles(imagePaths, text: 'Share');
        }).catchError((onError) {
          print(onError);
        });
      });
    } catch (e) {
      Logger().e("Error in captureSocialPng $e");
    }
  }
}
