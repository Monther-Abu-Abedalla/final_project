import 'package:consulting_app/feature/model/home/post_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../feature/view_model/home_view_model/home_view_model.dart';
import '../constance/constance.dart';

class DeepLinkService {
  // creat it sengleton
  DeepLinkService._internal();
  static final DeepLinkService instance = DeepLinkService._internal();

  final FirebaseDynamicLinks dl = FirebaseDynamicLinks.instance;
  static HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  Future<Uri> createPostLink(
      {required Post model, bool short = false}) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          '${Constance.instance.dynamicBaseLink}${Constance.instance.productParams}?id=${model.id}'),
      uriPrefix: Constance.instance.dynamicLinkPrefixUrl,
      androidParameters: AndroidParameters(
        packageName: Constance.instance.packageName,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: model.title,
        description: model.content,
        imageUrl: Uri.parse(model.makerImageUrl!),
      ),
      // iosParameters: IOSParameters(bundleId: Constants.instance.bundleId),
    );
    if (short) {
      ShortDynamicLink sdl = await dl.buildShortLink(dynamicLinkParams);
      return sdl.shortUrl;
    } else {
      return await dl.buildLink(
        dynamicLinkParams,
      );
    }
  }

  Future<void> initLinks() async {
    dl.onLink.listen((dynamicLinkData) async {
      final Uri deepLink = dynamicLinkData.link;
      bool isStory =
          deepLink.pathSegments.contains(Constance.instance.productParams);
      if (isStory) {
        try {
          Logger().e("deepLinkData");
          //  String? id = deepLink.queryParameters[ProductModel.keyId];
          //  await FirebaseFirestore.instance.collection(Constants.instance.productCollection).doc(id).get().then((value){
          //    homeViewModel.productModel =  ProductModel.fromDocumentSnapshot(value);
          //    Get.to(()=> const ProductDetails());
          //    });
        } on PlatformException catch (e) {
          printError(info: 'Error : ${e.toString()}');
        } catch (e) {
          printError(info: 'Error : ${e.toString()}');
        }
      }
    }).onError((error) {
      printError(info: 'Error : ${error.toString()}');
    });

    final PendingDynamicLinkData? pdld = await dl.getInitialLink();
    Uri? deepLink = pdld?.link;

    if (deepLink == null) return;
    try {
      String? id = deepLink.queryParameters["id"];

      Logger().e("deepLinkData ID : $id");
      //  await FirebaseFirestore.instance.collection(Constants.instance.productCollection).doc(id).get().then((value){
      //    homeViewModel.productModel =  ProductModel.fromDocumentSnapshot(value);
      //    Get.to(()=> const ProductDetails());
      //    });
    } on PlatformException catch (e) {
      printError(info: 'Error : ${e.toString()}');
    } catch (e) {
      printError(info: 'Error : ${e.toString()}');
    }
  }
}
