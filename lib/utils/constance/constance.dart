class Constance {
  static Constance instance = Constance._();

  final int isHide = 0;
  final int isViwer = 1;

  Constance._();

  // to do Login State User ::
  final String userLoggedState = "userLoginedState";
  final String userEnterdState = "userEnterdState";
  final String chooseTopicsState = "userChooseTopicState";
  final String userAddCertificates = "userAddCertificates";
  final String data = "data";

  final String dynamicBaseLink = "https://consuliting.page.link";
  final String dynamicLinkPrefixUrl = "https://consuliting.page.link/posts";
  final String productParams = "product";
  final String packageName = "com.makkahappyshopping";

  // to do User Types:
  final String consultantUserType = "consultant";
  final String questionerUserType = "questioner";

  final String tajawalFont = "Tajawal";

  // account Status Types;
  final String accountStatusPending = "حسابك قيد المراجعة";
  final String accountStatusAccepted = "تم تسجيل دخولك بنجاح";
  final String accountStatusUnacceptable = "تم رفض حسابك";

  // network Constance ::
  final String postId = "postId";
  final String id = "id";
  final String shareRequsetId = "share_request_id";

  // to do here Notifications Constance ::

  final int postAddedToMe = 1;
  final int newComment = 2;
  final int changeAccountStatusId = 3;
  final int forNewAccount = 4;
  final int needPayment = 5;
  final int successPayment = 6;
  final int requestShare = 7;
  final int requestShareReplay = 8;

  final String extraTimePrice = "extraTimePrice";
  final String extraTime = "extraTime";

  final String imagePlaceHolder =
      "https://cdn3.vectorstock.com/i/thumb-large/54/17/person-gray-photo-placeholder-man-vector-24005417.jpg";
}
