import 'package:consulting_app/feature/view/screens/home/widgets/post.dart';
import 'package:flutter/material.dart';


class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("استشاراتي"),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: 3,
          itemBuilder: (context, index) => PostItem(),
        ));
  }
}
