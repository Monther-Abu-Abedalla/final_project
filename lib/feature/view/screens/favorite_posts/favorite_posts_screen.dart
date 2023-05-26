import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/empty_place_holder.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       Provider.of<HomeViewModel>(context, listen: false).getFavoritePosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المفضلة"),
      ),
      body: Consumer<HomeViewModel>(
        builder: (_, builder, __) {
          if (builder.isLoading) {
            return const CustomLoading();
          } else if (builder.favoritePosts.isEmpty) {
            return const EmptyPlaceHolder(
              imagePath: "assets/svgs/empty_place_holder_2.svg",
              title: "لم تقم باضافة اية استشارات للمفضلة",
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: builder.favoritePosts.length,
              itemBuilder: (context, index) => PostItem(
                post: builder.favoritePosts.toList()[index],
              ),
            );
          }
        },
      ),
    );
  }
}
