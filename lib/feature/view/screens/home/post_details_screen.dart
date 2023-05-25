import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post_details_item.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post_time.dart';
import 'package:consulting_app/feature/view/widget/three_size_dot.dart';
import 'package:consulting_app/feature/view_model/post_view_model/post_details_view_model.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen(
      {Key? key, required this.postId, required this.isFromNotification})
      : super(key: key);

  final int postId;
  final bool isFromNotification;

  Future<bool> onWillPop() async {
    if (isFromNotification) {
      Get.off(() => const HomeScreen());
    } else {
      Get.back();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: ChangeNotifierProvider<PostDetailsViewModel>(
        create: (_) => PostDetailsViewModel(postId: postId),
        child: Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (context) {
                if (Provider.of<PostDetailsViewModel>(context).isLoading) {
                  return const SizedBox();
                } else {
                  return Text(context
                          .watch<PostDetailsViewModel>()
                          .operationPost
                          .title ??
                      "");
                }
              },
            ),
            actions: [
              Builder(
                builder: (context) {
                  if (Provider.of<PostDetailsViewModel>(context).isLoading) {
                    return const SizedBox();
                  }
                  if (Provider.of<PostDetailsViewModel>(context)
                          .operationPost
                          .makerId !=
                      SharedPref.instance.getCurrentUserData()?.id) {
                    return const SizedBox();
                  } else if (Provider.of<PostDetailsViewModel>(context)
                      .isLoadingDelete) {
                    return const ThreeSizeDot();
                  } else {
                    return IconButton(
                      onPressed: () async {
                        await context
                            .watch<PostDetailsViewModel>()
                            .deletePost(postId: postId);
                      },
                      icon: const Icon(Icons.delete),
                    );
                  }
                },
              ),
              const SizedBox(
                width: 12,
              ),
              Builder(
                builder: (context) {
                  if (Provider.of<PostDetailsViewModel>(context).isLoading) {
                    return const SizedBox();
                  } else if (context
                          .watch<PostDetailsViewModel>()
                          .operationPost
                          .makerId !=
                      SharedPref.instance.getCurrentUserData()?.id) {
                    return const SizedBox();
                  } else {
                    if (context
                            .watch<PostDetailsViewModel>()
                            .operationPost
                            .type !=
                        1) {
                      return IconButton(
                          onPressed: () {
                            context
                                .watch<PostDetailsViewModel>()
                                .getConsultationSubscription(
                                  postId: postId,
                                );
                          },
                          icon: const Icon(Icons.refresh_outlined));
                    } else {
                      return const SizedBox();
                    }
                  }
                },
              )
            ],
          ),
          body: Builder(
            builder: (context) {
              if (Provider.of<PostDetailsViewModel>(context).isLoading) {
                return const CustomLoading();
              } else if (Provider.of<PostDetailsViewModel>(context)
                      .operationPost
                      .id ==
                  null) {
                return const SizedBox();
              } else {
                return Stack(
                  children: [
                    ListView(
                      primary: true,
                      children: [
                        if (Provider.of<PostDetailsViewModel>(context)
                                .operationPost
                                .type !=
                            1) ...[
                          PostTime(
                            endDateTime:
                                Provider.of<PostDetailsViewModel>(context)
                                        .operationPost
                                        .expiresAt ??
                                    0,
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              PostDetailsItem(
                                post: Provider.of<PostDetailsViewModel>(context)
                                    .operationPost,
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        )
                      ],
                    ),
                    if (Provider.of<PostDetailsViewModel>(context)
                        .isCanComment()) ...[
                      Positioned(
                        right: 20,
                        left: 20,
                        bottom: 20,
                        child: Row(
                          children: [
                            Builder(
                              builder: (home) {
                                return Column(
                                  children: [
                                    IconButton(
                                      icon: Provider.of<PostDetailsViewModel>(context).isLoadingAddComment
                                          ? ThreeSizeDot(
                                              color_1: ColorManger
                                                  .instance.primaryColor,
                                              color_2: ColorManger
                                                  .instance.primaryColor,
                                              color_3: ColorManger
                                                  .instance.primaryColor,
                                              size: 3,
                                            )
                                          : const Text("نشر"),
                                      onPressed: () async {
                                        Provider.of<PostDetailsViewModel>(context , listen: false).onAddNewComment();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            Expanded(
                              child: TextFormField(
                                controller:
                                    Provider.of<PostDetailsViewModel>(context)
                                        .tdComment,
                                decoration: const InputDecoration(
                                  labelText: "تعليق",
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
