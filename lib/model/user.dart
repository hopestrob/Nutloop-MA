class UserModel {
  Data data;
  String message;
  int statusCode;

  UserModel({this.data, this.message, this.statusCode});

  UserModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  String emailVerifiedAt;
  String phoneNumberVerifiedAt;
  String psCusId;
  String socialProvider;
  String createdAt;
  String updatedAt;
  String referCode;

  User(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.emailVerifiedAt,
      this.phoneNumberVerifiedAt,
      this.psCusId,
      this.socialProvider,
      this.createdAt,
      this.updatedAt,
      this.referCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    emailVerifiedAt = json['email_verified_at'];
    phoneNumberVerifiedAt = json['phone_number_verified_at'];
    psCusId = json['ps_cus_id'];
    socialProvider = json['social_provider'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referCode = json['refer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_number_verified_at'] = this.phoneNumberVerifiedAt;
    data['ps_cus_id'] = this.psCusId;
    data['social_provider'] = this.socialProvider;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['refer_code'] = this.referCode;
    return data;
  }
}