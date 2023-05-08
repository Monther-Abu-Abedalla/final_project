import 'package:consulting_app/feature/core/theme/color/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  Utils._();

  static Utils instance = Utils._();

  mainSnack({String? title, required String body, Color? backgroundColor}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor ?? const Color(0xFF303030),
        message: body,
        duration: const Duration(seconds: 2),
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }

  snackSuccess({String? title, required String body}) {
    mainSnack(body: body, backgroundColor: ColorManger.instance.successColor);
  }

  snackError({String? title, required String body}) {
    mainSnack(body: body, backgroundColor: ColorManger.instance.errorColor);
  }

  // Future<File> compressImage(File file) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir.path;
  //   int rand = math.Random().nextInt(10000);

  //   img.Image? images = img.decodeImage(file.readAsBytesSync());
  //   img.Image? smallerImage = img.copyResize(images!);

  //   // choose the size here, it will maintain aspect ratio

  //   var compressedImage = File('$path/img_$rand.jpg')
  //     ..writeAsBytesSync(img.encodeJpg(/*image*/ smallerImage, quality: 95));
  //   return compressedImage;
  // }

  bool isValidatePassword({required String password}) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  BouncingScrollPhysics getIosScroll() {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
