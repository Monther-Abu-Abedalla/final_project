import 'package:consulting_app/feature/model/auth/topic_model.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: ( _ ,homeViewModel , __) {
        return Column(
          children: [
            SeconderyButton(
              textButton: topic.name ?? "",
              onClicked: () {
                homeViewModel.addTopic(topic);
              },
            ),
            const SizedBox(
              height: 12,
            )
          ],
        );
      }
    );
  }
}
