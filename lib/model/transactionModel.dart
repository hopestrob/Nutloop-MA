class TransactionModel {
  int id;
  int userId;
  int walletId;
  int orderId;
  String info;
  String type;
  String creditAmount;
  String cardAmount;
  String debitAmount;
  String closingBalance;
  String trxResponse;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String trxExternalRef;
  String paymentStatus;

  TransactionModel(
      {this.id,
      this.userId,
      this.walletId,
      this.orderId,
      this.info,
      this.type,
      this.creditAmount,
      this.cardAmount,
      this.debitAmount,
      this.closingBalance,
      this.trxResponse,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.trxExternalRef,
      this.paymentStatus});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    walletId = json['wallet_id'];
    orderId = json['order_id'];
    info = json['info'];
    type = json['type'];
    creditAmount = json['credit_amount'];
    cardAmount = json['card_amount'];
    debitAmount = json['debit_amount'];
    closingBalance = json['closing_balance'];
    trxResponse = json['trx_response'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trxExternalRef = json['trx_external_ref'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['wallet_id'] = this.walletId;
    data['order_id'] = this.orderId;
    data['info'] = this.info;
    data['type'] = this.type;
    data['credit_amount'] = this.creditAmount;
    data['card_amount'] = this.cardAmount;
    data['debit_amount'] = this.debitAmount;
    data['closing_balance'] = this.closingBalance;
    data['trx_response'] = this.trxResponse;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['trx_external_ref'] = this.trxExternalRef;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
