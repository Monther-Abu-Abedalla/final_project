class NotificationModel {
    NotificationModel({
        this.id,
        this.userId,
        this.postId,
        this.extraTime,
        this.extraTimePrice,
        this.commentMakerId,
        this.postMakerId,
        this.postReceiverId,
        this.shareRequestMakerId,
        this.commentContent,
        this.shareStatus,
        this.postContent,
        this.commentMakerViewingType,
        this.postMakerViewingType,
        this.postType,
        this.notificationAr,
        this.notificationEn,
        this.shareRequestId
    });

    int? id;
    int? userId;
    int? postId;
    int? extraTime;
    int? extraTimePrice;
    int? commentMakerId;
    int? postMakerId;
    int? postReceiverId;
    int? shareRequestMakerId;
    dynamic commentContent;
    int? shareStatus;
    dynamic postContent;
    int? commentMakerViewingType;
    int? postMakerViewingType;
    int? postType;
    int? shareRequestId;
    String? notificationAr;
    String? notificationEn;

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userId: json["userId"],
        postId: json["postId"],
        extraTime: json["extraTime"],
        extraTimePrice: json["extraTimePrice"],
        commentMakerId: json["commentMakerId"],
        postMakerId: json["postMakerId"],
        postReceiverId: json["postReceiverId"],
        shareRequestMakerId: json["shareRequestMakerId"],
        commentContent: json["commentContent"],
        shareStatus: json["shareStatus"],
        postContent: json["postContent"],
        commentMakerViewingType: json["commentMakerViewingType"],
        postMakerViewingType: json["postMakerViewingType"],
        postType: json["postType"],
        notificationAr: json["notification_ar"],
        notificationEn: json["notification_en"],
        shareRequestId: json["shareRequestId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "postId": postId,
        "extraTime": extraTime,
        "extraTimePrice": extraTimePrice,
        "commentMakerId": commentMakerId,
        "postMakerId": postMakerId,
        "postReceiverId": postReceiverId,
        "shareRequestMakerId": shareRequestMakerId,
        "commentContent": commentContent,
        "shareStatus": shareStatus,
        "postContent": postContent,
        "commentMakerViewingType": commentMakerViewingType,
        "postMakerViewingType": postMakerViewingType,
        "postType": postType,
        "notification_ar": notificationAr,
        "notification_en": notificationEn,
        "shareRequestId": shareRequestId,
    };
}

