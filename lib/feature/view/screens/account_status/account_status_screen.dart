import 'package:consulting_app/feature/view/screens/home/home_screen.dart';
import 'package:consulting_app/feature/view/screens/home/widgets/custom_loading.dart';
import 'package:consulting_app/feature/view_model/home_view_model/home_view_model.dart';
import 'package:consulting_app/utils/constance/constance.dart';
import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AccountStatusScreen extends StatefulWidget {
  const AccountStatusScreen({Key? key, required this.isFromNotification})
      : super(key: key);

  final bool isFromNotification;

  @override
  State<AccountStatusScreen> createState() => _AccountStatusScreenState();
}

class _AccountStatusScreenState extends State<AccountStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeViewModel>(context, listen: false).getProfile();
    });
  }

  Widget image() {
    String imagePath = "assets/svgs/pending.svg";

    if (SharedPref.instance.getAccountStatus() ==
        Constance.instance.accountStatusAccepted) {
      imagePath = "assets/svgs/accpted.svg";
    } else if (SharedPref.instance.getAccountStatus() ==
        Constance.instance.accountStatusUnacceptable) {
      imagePath = "assets/svgs/unaccepted.svg";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SvgPicture.asset(
        imagePath,
        width: 200,
        height: 200,
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (widget.isFromNotification) {
      Get.off(() => const HomeScreen());
    } else {
      Get.back();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("حالة حسابي"),
          leading: IconButton(
            onPressed: () {
              onWillPop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Consumer<HomeViewModel>(
          builder: (_, home, __) {
            if (home.isLoadingProfile) {
              return const CustomLoading();
            } else if (GetUtils.isNull(
                SharedPref.instance.getCurrentUserData()?.email)) {
              return const SizedBox();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 24,
                    width: double.infinity,
                  ),
                  image(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    SharedPref.instance.getAccountStatus(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                        SharedPref.instance.getCurrentUserData()?.denyReason ??
                            ""),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
