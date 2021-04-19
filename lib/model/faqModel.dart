class FaqModel {
  int id;
  String question;
  String answer;
  int defaultOpen;
  Null createdAt;
  Null updatedAt;

  FaqModel(
      {this.id,
      this.question,
      this.answer,
      this.defaultOpen,
      this.createdAt,
      this.updatedAt});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    defaultOpen = json['defaultOpen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['defaultOpen'] = this.defaultOpen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}