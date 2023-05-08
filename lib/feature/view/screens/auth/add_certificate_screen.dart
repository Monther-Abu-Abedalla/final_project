import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddSertificateScreen extends StatelessWidget {
  const AddSertificateScreen({Key? key}) : super(key: key);

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
                    Row(
                      children: [
                        Row(
                          children: [
                            FloatingActionButton(
                              onPressed: () {},
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
                              style: TextManger.instance.textStyleWhiteColorh5,
                            )
                          ],
                        ),
                      ],
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
                child: SeconderyButton(
                  onClicked: () async {},
                  textButton: "رفع الان",
                ))
          ],
        ),
      ),
    );
  }
}
