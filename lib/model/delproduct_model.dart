class ProductModel {
  String categoryName;
  String description;
  String color;
  List<Products> products;

  ProductModel(
      {this.categoryName, this.description, this.color, this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    description = json['description'];
    color = json['color'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['color'] = this.color;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String productId;
  String productName;
  String price;
  String imageUrl;

  Products({this.productId, this.productName, this.price, this.imageUrl});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['product_name'];
    price = json['price'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
