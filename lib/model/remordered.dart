class OrderedModel {
  Data data;
  String message;
  int statusCode;

  OrderedModel({this.data, this.message, this.statusCode});

  OrderedModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String orderNo;
  int userId;
  int addressId;
  int total;
  int deliveryCharges;
  String paymentMode;
  OrderStatus orderStatus;
  String orderNotes;
  int receiptId;
  String createdAt;
  String updatedAt;
  int orderStatusesId;
  String deliveryMode;
  Null deletedAt;
  String paymentStatus;
  Null trFailReason;
  Null psRef;
  AddressDetails addressDetails;
  List<OrderStatusHistory> orderStatusHistory;
  List<Items> items;

  Data(
      {this.id,
      this.orderNo,
      this.userId,
      this.addressId,
      this.total,
      this.deliveryCharges,
      this.paymentMode,
      this.orderStatus,
      this.orderNotes,
      this.receiptId,
      this.createdAt,
      this.updatedAt,
      this.orderStatusesId,
      this.deliveryMode,
      this.deletedAt,
      this.paymentStatus,
      this.trFailReason,
      this.psRef,
      this.addressDetails,
      this.orderStatusHistory,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    userId = json['user_id'];
    addressId = json['address_id'];
    total = json['total'];
    deliveryCharges = json['delivery_charges'];
    paymentMode = json['payment_mode'];
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
    orderNotes = json['order_notes'];
    receiptId = json['receipt_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatusesId = json['order_statuses_id'];
    deliveryMode = json['delivery_mode'];
    deletedAt = json['deleted_at'];
    paymentStatus = json['payment_status'];
    trFailReason = json['tr_fail_reason'];
    psRef = json['ps_ref'];
    addressDetails = json['address_details'] != null
        ? new AddressDetails.fromJson(json['address_details'])
        : null;
    if (json['order_status_history'] != null) {
      orderStatusHistory = <OrderStatusHistory>[];
      json['order_status_history'].forEach((v) {
        orderStatusHistory.add(new OrderStatusHistory.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['total'] = this.total;
    data['delivery_charges'] = this.deliveryCharges;
    data['payment_mode'] = this.paymentMode;
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus.toJson();
    }
    data['order_notes'] = this.orderNotes;
    data['receipt_id'] = this.receiptId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_statuses_id'] = this.orderStatusesId;
    data['delivery_mode'] = this.deliveryMode;
    data['deleted_at'] = this.deletedAt;
    data['payment_status'] = this.paymentStatus;
    data['tr_fail_reason'] = this.trFailReason;
    data['ps_ref'] = this.psRef;
    if (this.addressDetails != null) {
      data['address_details'] = this.addressDetails.toJson();
    }
    if (this.orderStatusHistory != null) {
      data['order_status_history'] =
          this.orderStatusHistory.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderStatus {
  int id;
  String name;
  Null createdAt;
  Null updatedAt;

  OrderStatus({this.id, this.name, this.createdAt, this.updatedAt});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AddressDetails {
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
  Null deletedAt;
  String createdAt;
  String updatedAt;

  AddressDetails(
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

  AddressDetails.fromJson(Map<String, dynamic> json) {
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

class OrderStatusHistory {
  int id;
  int orderId;
  int isNotified;
  String createdAt;
  String updatedAt;
  int statusId;
  OrderStatus orderStatus;

  OrderStatusHistory(
      {this.id,
      this.orderId,
      this.isNotified,
      this.createdAt,
      this.updatedAt,
      this.statusId,
      this.orderStatus});

  OrderStatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isNotified = json['is_notified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusId = json['status_id'];
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['is_notified'] = this.isNotified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status_id'] = this.statusId;
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus.toJson();
    }
    return data;
  }
}

class Items {
  int id;
  String subOrderNo;
  int orderId;
  int productId;
  int mUnitId;
  int quantity;
  int price;
  String createdAt;
  Null updatedAt;
  int priceId;
  Product product;
  DefaultPrice defaultPrice;
  UnitDetails unitDetails;

  Items(
      {this.id,
      this.subOrderNo,
      this.orderId,
      this.productId,
      this.mUnitId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.priceId,
      this.product,
      this.defaultPrice,
      this.unitDetails});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subOrderNo = json['sub_order_no'];
    orderId = json['order_id'];
    productId = json['product_id'];
    mUnitId = json['m_unit_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priceId = json['price_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    defaultPrice = json['default_price'] != null
        ? new DefaultPrice.fromJson(json['default_price'])
        : null;
    unitDetails = json['unit_details'] != null
        ? new UnitDetails.fromJson(json['unit_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_order_no'] = this.subOrderNo;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['m_unit_id'] = this.mUnitId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['price_id'] = this.priceId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.defaultPrice != null) {
      data['default_price'] = this.defaultPrice.toJson();
    }
    if (this.unitDetails != null) {
      data['unit_details'] = this.unitDetails.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String name;
  int categoryId;
  String description;
  String images;
  int brandId;
  String createdAt;
  String updatedAt;
  bool isBestDeal;
  bool isBestSelling;
  String sku;
  String freshness;
  String deliveryDays;
  String farm;
  String deliveryArea;
  int rating;

  Product(
      {this.id,
      this.name,
      this.categoryId,
      this.description,
      this.images,
      this.brandId,
      this.createdAt,
      this.updatedAt,
      this.isBestDeal,
      this.isBestSelling,
      this.sku,
      this.freshness,
      this.deliveryDays,
      this.farm,
      this.deliveryArea,
      this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    description = json['description'];
    images = json['images'];
    brandId = json['brand_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isBestDeal = json['is_best_deal'];
    isBestSelling = json['is_best_selling'];
    sku = json['sku'];
    freshness = json['freshness'];
    deliveryDays = json['delivery_days'];
    farm = json['farm'];
    deliveryArea = json['delivery_area'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['images'] = this.images;
    data['brand_id'] = this.brandId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_best_deal'] = this.isBestDeal;
    data['is_best_selling'] = this.isBestSelling;
    data['sku'] = this.sku;
    data['freshness'] = this.freshness;
    data['delivery_days'] = this.deliveryDays;
    data['farm'] = this.farm;
    data['delivery_area'] = this.deliveryArea;
    data['rating'] = this.rating;
    return data;
  }
}

class DefaultPrice {
  int id;
  int unitId;
  int productId;
  String priceRegular;
  String pricePromo;
  String secondaryRegularPrice;
  String secondaryPromoPrice;
  Null createdAt;
  Null updatedAt;

  DefaultPrice(
      {this.id,
      this.unitId,
      this.productId,
      this.priceRegular,
      this.pricePromo,
      this.secondaryRegularPrice,
      this.secondaryPromoPrice,
      this.createdAt,
      this.updatedAt});

  DefaultPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    productId = json['product_id'];
    priceRegular = json['price_regular'];
    pricePromo = json['price_promo'];
    secondaryRegularPrice = json['secondary_regular_price'];
    secondaryPromoPrice = json['secondary_promo_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unit_id'] = this.unitId;
    data['product_id'] = this.productId;
    data['price_regular'] = this.priceRegular;
    data['price_promo'] = this.pricePromo;
    data['secondary_regular_price'] = this.secondaryRegularPrice;
    data['secondary_promo_price'] = this.secondaryPromoPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UnitDetails {
  int id;
  String name;
  String abbreviation;
  int sort;
  String createdAt;
  String updatedAt;

  UnitDetails(
      {this.id,
      this.name,
      this.abbreviation,
      this.sort,
      this.createdAt,
      this.updatedAt});

  UnitDetails.fromJson(Map<String, dynamic> json) {
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
