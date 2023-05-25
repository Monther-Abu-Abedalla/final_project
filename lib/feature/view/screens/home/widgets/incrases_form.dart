// ignore_for_file: must_be_immutable

import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/view/widget/primary_button.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'custom_loading.dart';

class IncraesesForm extends StatelessWidget {
  IncraesesForm({Key? key}) : super(key: key);

  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManger.instance.borderColor),
            borderRadius: BorderRadius.circular(16),
            color: ColorManger.instance.postBackgroundColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorManger.instance.backgroundColor,
            ),
            child: Form(
              key: myKey,
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  const Text("زيادة"),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: homeViewModel.tdTime,
                    validator: (e) {
                      if (e!.trim().isEmpty) {
                        return 'هذا الحقل فارغ';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: ColorManger.instance.errorColor,
                            fontSize: 10),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  )),
                  const Text("دقائق"),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(":"),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (e) {
                      if (e!.trim().isEmpty) {
                        return 'هذا الحقل فارغ';
                      }
                      return null;
                    },
                    controller: homeViewModel.tdPrice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            color: ColorManger.instance.errorColor,
                            fontSize: 10),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                  )),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("ريال"),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Consumer<HomeViewModel>(
          builder: (_, builder, __) {
            if (builder.isLoading) {
              return const CustomLoading();
            } else {
              return PrimaryButton(
                isLoading: builder.isLoading,
                textButton: "تأكيد",
                onClicked: () {
                  if (myKey.currentState!.validate()) {
                    builder.addConsultationSubscription(
                      postId: homeViewModel.operationPost.id ?? -1,
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}
