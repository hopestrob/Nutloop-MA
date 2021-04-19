class AddressBook {
  String firstName;
  String lastName;
  String phoneNumber;
  String houseNo;
  String street;
  String area;
  String city;
  String deliveryInstructions;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  AddressBook(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.houseNo,
      this.street,
      this.area,
      this.city,
      this.deliveryInstructions,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  AddressBook.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    houseNo = json['house_no'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    deliveryInstructions = json['delivery_instructions'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['house_no'] = this.houseNo;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['delivery_instructions'] = this.deliveryInstructions;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}