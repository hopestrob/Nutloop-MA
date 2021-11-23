class CategoryModel {
  int id;
  String name;
  String description;
  String icon;
  String createdAt;
  String updatedAt;
  String backgroundColor;
  String textColor;

  CategoryModel(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.backgroundColor,
      this.textColor});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['background_color'] = this.backgroundColor;
    data['text_color'] = this.textColor;
    return data;
  }
}