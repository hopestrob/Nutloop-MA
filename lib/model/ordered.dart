class OrderedModel {
  int id;
  String orderNo;
  int userId;
  int addressId;
  int total;
  int totalDiscount;
  int subTotal;
  int deliveryCharges;
  String paymentMode;
  OrderStatus orderStatus;
  String orderNotes;
  int receiptId;
  String createdAt;
  String updatedAt;
  int orderStatusesId;
  String deliveryMode;
  String deletedAt;
  String paymentStatus;
  String trFailReason;
  String psRef;
  List<Items> items;

  OrderedModel(
      {this.id,
      this.orderNo,
      this.userId,
      this.addressId,
      this.total,
      this.totalDiscount,
      this.subTotal,
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
      this.items});

  OrderedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    userId = json['user_id'];
    addressId = json['address_id'];
    total = json['total'];
    totalDiscount = json['total_discount'];
    subTotal = json['sub_total'];
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
    if (json['items'] != null) {
      // ignore: deprecated_member_use
      items = new List<Items>();
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
    data['total_discount'] = this.totalDiscount;
    data['sub_total'] = this.subTotal;
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
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderStatus {
  int id;
  String name;
  String createdAt;
  String updatedAt;

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

class Items {
  int id;
  String subOrderNo;
  int orderId;
  int productId;
  int mUnitId;
  int quantity;
  int price;
  String createdAt;
  String updatedAt;
  int priceId;
  int pricePromo;
  int priceRegular;
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
      this.pricePromo,
      this.priceRegular,
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
    pricePromo = json['price_promo'];
    priceRegular = json['price_regular'];
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
    data['price_promo'] = this.pricePromo;
    data['price_regular'] = this.priceRegular;
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
  String deletedAt;
  double rating;

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
      this.deletedAt,
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
    deletedAt = json['deleted_at'];
    rating = json['rating'].toDouble();
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
    data['deleted_at'] = this.deletedAt;
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
  String createdAt;
  String updatedAt;

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
