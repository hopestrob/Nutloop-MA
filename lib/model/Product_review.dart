class ProductModelReview {
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
  dynamic deletedAt;
  dynamic rating;
  List<Prices> prices;
  Brand brand;
  Category category;
  List<Reviews> reviews;

  ProductModelReview(
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
      this.rating,
      this.prices,
      this.brand,
      this.category,
      this.reviews});

  ProductModelReview.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    if (json['prices'] != null) {
      prices = new List<Prices>();
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
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
    data['deleted_at'] = this.deletedAt;
    data['rating'] = this.rating;
    if (this.prices != null) {
      data['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
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
  dynamic createdAt;
  dynamic updatedAt;
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

class Brand {
  int id;
  String name;
  String logo;
  String createdAt;
  String updatedAt;

  Brand({this.id, this.name, this.logo, this.createdAt, this.updatedAt});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Category {
  int id;
  String name;
  String description;
  String icon;
  String createdAt;
  String updatedAt;
  String backgroundColor;
  String textColor;
  int returnDays;
  String bannerImage;

  Category(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.backgroundColor,
      this.textColor,
      this.returnDays,
      this.bannerImage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
    returnDays = json['return_days'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['background_color'] = this.backgroundColor;
    data['text_color'] = this.textColor;
    data['return_days'] = this.returnDays;
    data['banner_image'] = this.bannerImage;
    return data;
  }
}

class Reviews {
  int id;
  int userId;
  int productId;
  String comment;
  int stars;
  String createdAt;
  String updatedAt;
  User user;

  Reviews(
      {this.id,
      this.userId,
      this.productId,
      this.comment,
      this.stars,
      this.createdAt,
      this.updatedAt,
      this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    comment = json['comment'];
    stars = json['stars'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['comment'] = this.comment;
    data['stars'] = this.stars;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic emailVerifiedAt;
  dynamic phoneNumberVerifiedAt;
  String psCusId;
  dynamic socialProvider;
  String createdAt;
  String updatedAt;
  String referCode;
  dynamic deletedAt;
  int amountSpent;

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
      this.deletedAt,
      this.amountSpent});

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
    amountSpent = json['amountSpent'];
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
    data['amountSpent'] = this.amountSpent;
    return data;
  }
}
