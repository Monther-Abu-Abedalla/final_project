// ignore_for_file: prefer_final_fields

import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:consulting_app/feature/core/theme/text_theme/text_manger.dart';
import 'package:consulting_app/feature/model/auth/user_model.dart';
import 'package:consulting_app/feature/view/screens/auth/register_screen.dart';
import 'package:consulting_app/feature/view/screens/auth/widgets/social_media.dart';
import 'package:consulting_app/feature/view/screens/auth/widgets/spacer_divider.dart';
import 'package:consulting_app/feature/view/widget/custom_text_field.dart';
import 'package:consulting_app/feature/view/widget/secondery_button.dart';
import 'package:consulting_app/feature/view_model/auth_view_model/auth_view_model.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:consulting_app/utils/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static final AuthViewModel _authViewModel =
      Get.put(AuthViewModel(), permanent: true);
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  backgroundColor: ColorManger.instance.transColor,
                  radius: 80,
                  child: SvgPicture.asset("assets/svgs/logo.svg"),
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      "تسجيل الدخول",
                      textAlign: TextAlign.start,
                      style: TextManger.instance.textStyleh4,
                    )),
                const SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  controller: _authViewModel.tdEmail,
                  label: "الايميل",
                  suffixPath: "assets/svgs/message.svg",
                  isEmail: true,
                  validation: (e) {
                    if (!GetUtils.isEmail(e)) {
                      return "بريد الكتروني غير صالح";
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _authViewModel.tdPassword,
                  label: "كلمة المرور",
                  suffixPath: "assets/svgs/password.svg",
                  isPassword: true,
                  validation: (e) {
                    if (e.isEmpty || e.length < 6) {
                      return 'كلمة المرور غير صالحة';
                    } else if (!Utils.instance
                        .isValidatePassword(password: e.toString())) {
                      return 'يجب أن تحتوي كلمة مرورك على رمز و رقم واحد و حرف صغير و حرف كبير على الأقل';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const SpacerDivider(),
                const SizedBox(
                  height: 32,
                ),
                const SocialMedia(isLogin: true),
                const SizedBox(
                  height: 32,
                ),
                Consumer<AuthViewModel>(
                  builder: (_, auth, __) {
                    if (!GetUtils.isNull(
                        SharedPref.instance.getCurrentUserData()?.token)) {
                      return Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: SeconderyButton(
                              textButton: "تسجيل الدخول",
                              isLoading: auth.isLoading,
                              onClicked: () async {
                                if (_key.currentState!.validate()) {
                                  auth.signIn(
                                      user: UserModel(
                                    email: auth.tdEmail.text,
                                    password: auth.tdPassword.text,
                                    type: SharedPref.instance.getUserType(),
                                    fcm: SharedPref.instance.getFCMToken(),
                                    deviceId: auth.identifier,
                                  ));
                                }
                              },
                            ),
                          ),
                          IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () async {
                                await auth.authenticate();
                              },
                              icon: SvgPicture.asset(
                                "assets/svgs/fingerPrint.svg",
                                fit: BoxFit.fill,
                              ))
                        ],
                      );
                    } else {
                      return SeconderyButton(
                        height: 40,
                        textButton: "تسجيل الدخول",
                        isLoading: _authViewModel.isLoading,
                        onClicked: () {
                          if (_key.currentState!.validate()) {
                            _authViewModel.signIn(
                                user: UserModel(
                              email: _authViewModel.tdEmail.text,
                              password: _authViewModel.tdPassword.text,
                              type: SharedPref.instance.getUserType(),
                              fcm: SharedPref.instance.getFCMToken(),
                              deviceId: _authViewModel.identifier,
                            ));
                          }
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    highlightColor: ColorManger.instance.transColor,
                    splashColor: ColorManger.instance.transColor,
                    onTap: () {
                      Get.off(() => RegisterScreen());
                    },
                    child: RichText(
                      text: TextSpan(
                          text: 'ليس لديك حساب بعد ؟',
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' انشاء حساب ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: ColorManger
                                          .instance.seconderyDarkColor),
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
