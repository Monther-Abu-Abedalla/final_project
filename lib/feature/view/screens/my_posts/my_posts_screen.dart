import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/empty_place_holder.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeViewModel>(context, listen: false).getMyPosts();
    });
    super.initState();
  }

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
              itemCount: builder.myPosts.length,
              itemBuilder: (context, index) =>
                  PostItem(post: builder.myPosts.toList()[index]),
            );
          }
        },
      ),
    );
  }
}
