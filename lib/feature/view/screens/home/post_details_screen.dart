import 'package:consulting_app/feature/view/screens/home/widgets/post_details_item.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Scaffold(
          appBar: AppBar(
            title: GetBuilder<HomeViewModel>(
              builder: (logic) {
                if (logic.isLoading) {
                  return const SizedBox();
                } else {
                  return const Text("");
                }
              },
            ),
            actions: [
              GetBuilder<HomeViewModel>(
                builder: (builder) {
                  if (builder.isLoading) {
                    return const SizedBox();
                  }

                  return IconButton(
                    onPressed: () async {},
                    icon: const Icon(Icons.delete),
                  );
                },
              ),
              const SizedBox(
                width: 12,
              ),
              GetBuilder<HomeViewModel>(
                builder: (home) {
                  return const SizedBox();
                },
              )
            ],
          ),
          body: Stack(
            children: [
              ListView(
                primary: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: const [
                        SizedBox(height: 20),
                        PostDetailsItem(),
                        SizedBox(height: 100),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                right: 20,
                left: 20,
                bottom: 20,
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Text("نشر"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: "تعليق",
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
