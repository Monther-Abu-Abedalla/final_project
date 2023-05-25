class Comment {
  Comment(
      {this.id,
      this.postId,
      this.makerId,
      this.content,
      this.makerName,
      this.createdAt,
      this.makerViewingType,
      this.makerImageUrl});
  int? id;
  int? postId;
  int? makerId;
  String? content;
  String? makerName;
  num? createdAt;
  int? makerViewingType;
  String? makerImageUrl;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        postId: json["postId"],
        makerId: json["makerId"],
        makerImageUrl: json["makerImageUrl"],
        content: json["content"],
        makerViewingType: json["makerViewingType"],
        makerName: json["makerName"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "postId": postId,
        "makerId": makerId,
        "content": content,
        "makerImageUrl": makerImageUrl,
        "makerName": makerName,
        "makerViewingType": makerViewingType,
        "createdAt": createdAt,
      };
}
