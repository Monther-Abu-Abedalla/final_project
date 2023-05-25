class CommonQuestion {
    CommonQuestion({
        this.id,
        this.question,
        this.answer,
        this.isExpanded,
    });

    int? id;
    String? question;
    String? answer;
    bool? isExpanded;

    factory CommonQuestion.fromJson(Map<String, dynamic> json) => CommonQuestion(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
    };
}