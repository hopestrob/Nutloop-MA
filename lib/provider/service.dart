import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/products_class.dart';

class ProviderClass extends ChangeNotifier {
  Api api = new Api();

  // for Top selling
  ProductClass _topSellingProductsproductClass = ProductClass();
  List<Data> topSellingProducts = [];

  // for Best Deals
  ProductClass _bestdealproductClass = ProductClass();
  List<Data> bestdealProducts = [];

  bool isLoading = true;

  ProviderClass() {
    // for Top selling
    _topSellingProductsproductClass.data = topSellingProducts;

    //for Best Deal Products
    _bestdealproductClass.data = bestdealProducts;
  }

// for Top selling
  settopSellingProducts(ProductClass data) {
    _topSellingProductsproductClass = data;
    isLoading = false;
    notifyListeners();
  }

  // for Best Deals
  setBestDealProducts(ProductClass data) {
    _bestdealproductClass = data;
    isLoading = false;
    notifyListeners();
  }

  // for Top selling
  ProductClass gettopSellingProducts() {
    return _topSellingProductsproductClass;
  }

  // for Best Deal
  ProductClass getBestDealProducts() {
    return _bestdealproductClass;
  }

// for Top selling
  Future<ProductClass> hitApiTopSellingProducts() async {
    var response = await api.getProduct('/public/top-selling-products');
    final Map parsed = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    ProductClass topSellingProductsproductClass = ProductClass.fromJson(parsed);
    return topSellingProductsproductClass;
  }

// for Top selling
  Future<ProductClass> hitApiBestDealProducts() async {
    var response = await api.getProduct('/public/best-deals-products');
    final Map parsed = json.decode(response.body);
    if (response.statusCode != 200) {
      return null;
    }
    ProductClass topBestDealproductClass = ProductClass.fromJson(parsed);
    return topBestDealproductClass;
  }
}
