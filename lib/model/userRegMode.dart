class UserRegModel {
  Data data;
  String message;
  int statusCode;

  UserRegModel({this.data, this.message, this.statusCode});

  UserRegModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  User user;
  String token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String name;
  String email;
  String phoneNumber;
  String referCode;
  String updatedAt;
  String createdAt;
  int id;
  String psCusId;

  User(
      {this.name,
      this.email,
      this.phoneNumber,
      this.referCode,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.psCusId});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    referCode = json['refer_code'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    psCusId = json['ps_cus_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['refer_code'] = this.referCode;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['ps_cus_id'] = this.psCusId;
    return data;
  }
}
