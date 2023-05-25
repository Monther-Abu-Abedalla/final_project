import 'package:consulting_app/feature/model/home/comment_model.dart';

class Post {
  Post(
      {this.id,
      this.content,
      this.createdAt,
      this.expiresAt,
      this.makerViewingType,
      this.receiverId,
      this.title,
      this.topicId,
      this.makerName,
      this.comments,
      this.isFavorite,
      this.makerImageUrl,
      this.makerId,
      this.type});

  int? id;
  int? receiverId;
  int? topicId;
  String? title;
  String? content;
  int? type;
  int? makerViewingType;
  num? createdAt;
  num? expiresAt;
  String? makerName;
  List<Comment>? comments;
  bool? isFavorite;
  int? makerId;
  String? makerImageUrl;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        makerName: json["makerName"],
        receiverId: json["receiverId"],
        topicId: json["topicId"],
        title: json["title"],
        makerImageUrl: json["makerImageUrl"],
        content: json["content"],
        type: json["type"],
        makerId: json["makerId"],
        isFavorite: json["isFavorite"],
        makerViewingType: json["makerViewingType"],
        createdAt: json["createdAt"],
        expiresAt: json["expiresAt"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receiverId": receiverId,
        "topicId": topicId,
        "title": title,
        "content": content,
        "makerName": makerName,
        "type": type,
        "makerImageUrl": makerImageUrl,
        "makerId": makerId,
        "makerViewingType": makerViewingType,
        "createdAt": createdAt,
        "expiresAt": expiresAt,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
