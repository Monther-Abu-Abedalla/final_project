import 'package:consulting_app/feature/model/auth/topic_model.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class UserModel {
  UserModel(
      {this.username,
      this.email,
      this.type,
      this.deviceId,
      this.fcm,
      this.isApproved,
      this.token,
      this.socialId,
      this.denyReason,
      this.accountStatus,
      this.id,
      this.imageUrl,
      this.topics,
      this.password});
  int? id;
  String? username;
  String? email;
  String? type;
  String? deviceId;
  String? fcm;
  bool? isApproved;
  String? password;
  String? token;
  String? socialId;
  String? accountStatus;
  String? denyReason;
  List<Topic>? topics;
  String? imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      username: json["username"],
      email: json["email"],
      type: json["type"],
      id: json["id"],
      imageUrl: json["imageUrl"],
      denyReason: json["denyReason"],
      password: json["password"],
      deviceId: json["deviceId"],
      fcm: json["fcm"],
      topics: json["topics"] == null
          ? []
          : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
      isApproved: json["isApproved"],
      token: json["token"],
      accountStatus: json["account_status"],
      socialId: json["socialId"]);

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "type": type,
        "deviceId": deviceId,
        "fcm": fcm,
        "id": id,
        "imageUrl": imageUrl,
        "topics": (GetUtils.isNull(topics) || topics!.isEmpty)
            ? []
            : List<Topic>.from(topics!.map((e) => e.toJson())),
        "denyReason": denyReason,
        "socialId": socialId,
        "isApproved": isApproved,
        "token": token,
        "account_status": accountStatus,
        "password": password
      };
}
