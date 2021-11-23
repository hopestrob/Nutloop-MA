class AddressBook {
  int id;
  int userId;
  String firstName;
  String lastName;
  String phoneNumber;
  String mobileNumber;
  String houseNo;
  String street;
  String area;
  String city;
  String deliveryInstructions;
  String deletedAt;
  String createdAt;
  String updatedAt;

  AddressBook(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.mobileNumber,
      this.houseNo,
      this.street,
      this.area,
      this.city,
      this.deliveryInstructions,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  AddressBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    mobileNumber = json['mobile_number'];
    houseNo = json['house_no'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    deliveryInstructions = json['delivery_instructions'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['house_no'] = this.houseNo;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['delivery_instructions'] = this.deliveryInstructions;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
