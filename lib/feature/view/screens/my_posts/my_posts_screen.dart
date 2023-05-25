import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../widget/empty_place_holder.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("استشاراتي"),
      ),
      body: Consumer<HomeViewModel>(
        // initState: (_) {
        //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        //     await homeViewModel.getMyPosts();
        //   });
        // },
        builder: (_, builder, __) {
          if (builder.isLoading) {
            return const CustomLoading();
          } else if (builder.myPosts.isEmpty) {
            return const EmptyPlaceHolder(
              imagePath: "assets/svgs/empty_place_holder_1.svg",
              title: "لم تقم باضافة اية استشارات بعد",
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: homeViewModel.myPosts.length,
              itemBuilder: (context, index) =>
                  PostItem(post: homeViewModel.myPosts.toList()[index]),
            );
          }
        },
      ),
    );
  }
}
