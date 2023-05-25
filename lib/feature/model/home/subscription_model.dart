class Subscription {
  Subscription({this.extraTimePrice, this.postId, this.exteaTime});

  int? postId;
  num? extraTimePrice;
  num? exteaTime;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        extraTimePrice: json["extraTimePrice"],
        postId: json["postId"],
        exteaTime: json["extraTime"],
      );

  Map<String, dynamic> toJson() => {
        "extraTimePrice": extraTimePrice,
        "postId": postId,
        "extraTime": exteaTime,
      };
}
