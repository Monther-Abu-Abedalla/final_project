class Topic {
  Topic({this.id, this.name});

  int? id;
  String? name;

  factory Topic.fromJson(Map<String, dynamic> json) =>
      Topic(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Topic && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
