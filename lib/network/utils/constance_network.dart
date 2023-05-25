import 'package:consulting_app/utils/shared/sh_util.dart';
import 'package:get/get.dart';

abstract class ConstanceNetwork {
  // todo here for Api Contacnce And Base Url ::
  static String loginEndPoint = "auth/login.php";
  static String registerEndPoint = "auth/register.php";
  static String topicEndPoint = "auth/get_topics.php";
  static String sendCertificateEndPoint = "auth/upload_certificates.php";
  static String sendTopicsEndPoint = "auth/set_user_topics.php";

  // todo here Post EndPoint ::
  static String createPostEndPoint = "posts/create_post.php";
  static String getUserByTopicsEndPoint = "topics/get_consultants_by_topics.php?page=1";

  // todo here Privacy End Points :
  static String getPrivacyPolicyEndPoint = "app/privacy_policy.php";
  static String getAppSummaryEndPoint = "app/app_summary.php";
  static String commonQuestionsEndPoint = "app/common_questions.php";

  // todo here For Account Data:
  static String getAccountDataEndPoint = "user/profile.php";

  // post End Points:
  static String getHomeEndPoints = "posts/get_related_posts.php";
  static String createCommentEndPoint = "comments/create_comment.php";
  static String getPostDetailedEndPoint = "posts/get_post_details.php";
  static String addToFavoritesEndPoint = "posts/add_to_favorites.php";
  static String removeFromFavoritesEndPoint = "posts/remove_from_favorites.php";
  static String deletePostEndPoint = "posts/delete_post.php";
  static String getMyPostsEndPoint = "user/get_user_posts.php";
  static String getFavoritePostsEndPoint = "user/get_favorite_posts.php";
  static String sharePostEndPoint = "posts/share_request.php";
  static String updateShareRequestEndPoint = "posts/update_share_request_status.php";
  

  // conection between user And Questioner ::

  static String increaseTimeEndPoint = "posts/increase_time.php"; // for user
  static String addConsultationSubscriptionEndPoint = "posts/add_consultation_subscription.php"; // for مقدم الاستشارة
  static String getConsultationSubscriptionEndPoint = "posts/get_consultation_subscription.php"; // for مقدم الاستشارة

  static String getNotificationsEndPoint = "user/get_notifications.php";

  static String reportPostEndPoint = "posts/report_post.php";

  static String blockUserEndPoint = "user/block_user.php";

  static String repoCommentEndPoint = "comments/report_comment.php";

  // todo here for Header Requests ::
  static Map<String, String> header(int typeToken) {
    Map<String, String> headers = {};
    if (typeToken == 0) {
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': Get.locale.toString().split("_")[0],
      };
    } else if (typeToken == 1) {
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
    } else if (typeToken == 2) {
      headers = {
        'authorization': SharedPref.instance.getUserToken(),
      };
    } else if (typeToken == 3) {
      headers = {
        //  'Authorization': '${SharedPref.instance.getToken().toString()}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
    } else if (typeToken == 4) {
      // print("msg_get_user_token ${SharedPref.instance.getUserToken()}");
      headers = {
        'Authorization': "Bearer ${SharedPref.instance.getUserToken()}",
        'Content-Type': 'application/json',
        'Accept-Language': Get.locale.toString().split("_")[0],
        'Accept': 'application/json',
      };
    }

    return headers;
  }
}
