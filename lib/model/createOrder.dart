class CreateOrder {
  String addressId;
  String paymentMode;
  String deliveryMode;
  String orderNotes;
  int userId;
  int total;
  int deliveryCharges;
  int orderStatusesId;
  int receiptId;
  String orderNo;
  String updatedAt;
  String createdAt;
  int id;

  CreateOrder(
      {this.addressId,
      this.paymentMode,
      this.deliveryMode,
      this.orderNotes,
      this.userId,
      this.total,
      this.deliveryCharges,
      this.orderStatusesId,
      this.receiptId,
      this.orderNo,
      this.updatedAt,
      this.createdAt,
      this.id});

  CreateOrder.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    paymentMode = json['payment_mode'];
    deliveryMode = json['delivery_mode'];
    orderNotes = json['order_notes'];
    userId = json['user_id'];
    total = json['total'];
    deliveryCharges = json['delivery_charges'];
    orderStatusesId = json['order_statuses_id'];
    receiptId = json['receipt_id'];
    orderNo = json['order_no'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['payment_mode'] = this.paymentMode;
    data['delivery_mode'] = this.deliveryMode;
    data['order_notes'] = this.orderNotes;
    data['user_id'] = this.userId;
    data['total'] = this.total;
    data['delivery_charges'] = this.deliveryCharges;
    data['order_statuses_id'] = this.orderStatusesId;
    data['receipt_id'] = this.receiptId;
    data['order_no'] = this.orderNo;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}