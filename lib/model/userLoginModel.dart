class UserLoginModel {
  Data data;
  String message;
  int statusCode;

  UserLoginModel({this.data, this.message, this.statusCode});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
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
  String accessToken;
  String tokenType;
  int expiresIn;

  Data({this.user, this.accessToken, this.tokenType, this.expiresIn});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  Null emailVerifiedAt;
  Null phoneNumberVerifiedAt;
  String psCusId;
  Null socialProvider;
  String createdAt;
  String updatedAt;
  String referCode;
  Null deletedAt;

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
      this.referCode,
      this.deletedAt});

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
    deletedAt = json['deleted_at'];
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
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
