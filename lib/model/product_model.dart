import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) => List<ProductsModel>.from(json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
    ProductsModel({
        this.categoryName,
        this.description,
        this.color,
        this.products,
    });

    String categoryName;
    String description;
    String color;
    List<Product> products;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        categoryName: json["categoryName"],
        description: json["description"],
        color: json["color"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "description": description,
        "color": color,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        this.productId,
        this.productName,
        this.price,
        this.imageUrl,
        this.description
    });

    String productId;
    String productName;
    String price;
    String imageUrl;
    String description;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["ProductId"],
        productName: json["product_name"],
        price: json["price"],
        imageUrl: json["image_url"],
        description:json["description"]
    );

    Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "product_name": productName,
        "price": price,
        "image_url": imageUrl,
        "description": description,
    };
}
