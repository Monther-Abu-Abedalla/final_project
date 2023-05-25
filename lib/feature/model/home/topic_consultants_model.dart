class TopicConsultants {
  TopicConsultants({this.id, this.userName});

  int? id;
  String? userName;

  factory TopicConsultants.fromJson(Map<String, dynamic> json) =>
      TopicConsultants(id: json["id"], userName: json["username"]);

  Map<String, dynamic> toJson() => {"id": id, "username": userName};
}