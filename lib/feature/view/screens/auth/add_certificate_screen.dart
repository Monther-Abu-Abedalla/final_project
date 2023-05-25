import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:consulting_app/utils/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddCertificateScreen extends StatelessWidget {
  const AddCertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: ColorManger.instance.homeGradient),
            color: ColorManger.instance.primaryColor),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              primary: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/gifs/upload_certificates.gif",
                      height: 250,
                      width: 250,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "قم بارفاق الصور تؤكدك خبرتك في مجالات الاستشارات التي اخترتها",
                      style: TextManger.instance.textStyleWhiteColorh4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (_, builder, __) {
                        return Row(
                          children: [
                            Row(
                              children: [
                                FloatingActionButton(
                                  onPressed: () async {
                                    // await builder.showMultiSelected();
                                    await builder.getImage();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svgs/add_icon.svg",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "إضافة الشهادات",
                                  style:
                                      TextManger.instance.textStyleWhiteColorh5,
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Consumer<AuthViewModel>(
                      builder: (_, builder, __) {
                        return GridView(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 15),
                          children: builder.certificatesImages
                              .map((e) => Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Image.file(
                                      e,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                right: 20,
                left: 20,
                child: Consumer<AuthViewModel>(
                  builder: (_, build, __) {
                    return SeconderyButton(
                      isLoading: build.isLoading,
                      onClicked: () async {
                        if (build.certificatesImages.isEmpty) {
                          Utils.instance.snackError(body: "يجب إضافة شهادات");
                        } else {
                          await build.sendCertificate();
                        }
                      },
                      textButton: "رفع الان",
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
