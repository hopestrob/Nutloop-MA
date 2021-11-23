class UnitModel {
  int id;
  String name;
  String abbreviation;
  int sort;
  String createdAt;
  String updatedAt;

  UnitModel(
      {this.id,
      this.name,
      this.abbreviation,
      this.sort,
      this.createdAt,
      this.updatedAt});

  UnitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    sort = json['sort'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['sort'] = this.sort;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}