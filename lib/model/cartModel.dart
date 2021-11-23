class CartModel {
  Data data;
  String message;
  int statusCode;

  CartModel({this.data, this.message, this.statusCode});

  CartModel.fromJson(Map<String, dynamic> json) {
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
  List<Items> items;
  int total;

  Data({this.items, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Items {
  int id;
  int userId;
  int productId;
  int quantity;
  String createdAt;
  String updatedAt;
  int mUnitId;
  int priceId;
  Product product;
  Unit unit;
  DefaultPrice defaultPrice;

  Items(
      {this.id,
      this.userId,
      this.productId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.mUnitId,
      this.priceId,
      this.product,
      this.unit,
      this.defaultPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mUnitId = json['m_unit_id'];
    priceId = json['price_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    defaultPrice = json['default_price'] != null
        ? new DefaultPrice.fromJson(json['default_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['m_unit_id'] = this.mUnitId;
    data['price_id'] = this.priceId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit.toJson();
    }
    if (this.defaultPrice != null) {
      data['default_price'] = this.defaultPrice.toJson();
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
  double rating;
  List<Prices> prices;

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
      this.rating,
      this.prices});

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
    rating = json['rating'].toDouble();
    if (json['prices'] != null) {
      prices = <Prices>[];
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
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
    if (this.prices != null) {
      data['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prices {
  int id;
  int unitId;
  int productId;
  String priceRegular;
  String pricePromo;
  String secondaryRegularPrice;
  String secondaryPromoPrice;
  Null createdAt;
  Null updatedAt;
  Unit unit;

  Prices(
      {this.id,
      this.unitId,
      this.productId,
      this.priceRegular,
      this.pricePromo,
      this.secondaryRegularPrice,
      this.secondaryPromoPrice,
      this.createdAt,
      this.updatedAt,
      this.unit});

  Prices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitId = json['unit_id'];
    productId = json['product_id'];
    priceRegular = json['price_regular'];
    pricePromo = json['price_promo'];
    secondaryRegularPrice = json['secondary_regular_price'];
    secondaryPromoPrice = json['secondary_promo_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
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
    if (this.unit != null) {
      data['unit'] = this.unit.toJson();
    }
    return data;
  }
}

class Unit {
  int id;
  String name;
  String abbreviation;
  int sort;
  String createdAt;
  String updatedAt;

  Unit(
      {this.id,
      this.name,
      this.abbreviation,
      this.sort,
      this.createdAt,
      this.updatedAt});

  Unit.fromJson(Map<String, dynamic> json) {
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
