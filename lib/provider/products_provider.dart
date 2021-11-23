import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/allBestDealModel.dart';
import 'package:nuthoop/model/alltopsellingModel.dart';
import 'package:nuthoop/model/category_model.dart';
import 'package:nuthoop/model/faqModel.dart';
import 'package:nuthoop/model/products.dart';
// import 'package:nuthoop/model/products.dart' as Prices;
import 'package:nuthoop/model/unitModel.dart';
import 'package:nuthoop/model/whistList.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:async/async.dart';

enum ReviewProductState { initial, error, loading, complete }

class ProductsProvider with ChangeNotifier {
  Api api = new Api();
  List<CategoryModel> _getCategories = <CategoryModel>[];
  List<FaqModel> _getFaq = <FaqModel>[];
  List<ProductModel> _getProductFilter,
      _getProductTopSelling,
      _getProductCategory = <ProductModel>[];

  List<ProductAllTopModel> _getAllProductTopSelling = <ProductAllTopModel>[];
  List<ProductAllBestModel> _getAllProductBestDeal = <ProductAllBestModel>[];

  List<WhistlistModel> _getSavedItem = <WhistlistModel>[];
  var _getProductBestDeal = <ProductModel>[];
  var _getRecentView = <ProductModel>[];

  List<UnitModel> _getUnits = <UnitModel>[];

  ProductModel _getSingleProductFilter;
  ProductModel getSingleProduct() => _getSingleProductFilter;
  // final AsyncMemoizer _memoizer = AsyncMemoizer();

  List<FaqModel> get getFaq {
    return [...?_getFaq];
  }

  List<CategoryModel> get getCategoy {
    return [...?_getCategories];
  }

  List<UnitModel> get getUnits {
    return [...?_getUnits];
  }

  List<ProductModel> get getProductBestDeal {
    return [...?_getProductBestDeal];
  }

  List<ProductModel> get getRecentView {
    return [...?_getRecentView];
  }

  List<ProductModel> get getProductFilter {
    return [...?_getProductFilter];
  }

  List<ProductModel> get getProductTopSelling {
    return [...?_getProductTopSelling];
  }

  List<ProductModel> get getProductCategory {
    return [...?_getProductCategory];
  }

  List<ProductAllTopModel> get getAllProductTopSelling {
    return [...?_getAllProductTopSelling];
  }

  List<ProductAllBestModel> get getAllProductBestDeal {
    return [...?_getAllProductBestDeal];
  }

  List<WhistlistModel> get getSavedItem {
    return [...?_getSavedItem];
  }

  String _getpriceRegular;
  String get getpriceRegular => _getpriceRegular;

  String _getMeasurement;
  String get getMeasurement => _getMeasurement;

  setMeasurement(String measure) {
    _getMeasurement = measure;
    notifyListeners();
  }

  ProductsProvider() {
    getCategories();
    // getproductBestDeals();
    // getproductTopDeals();
    // getAllproductTopDeals();
    getFaqies();
    getSavedItemsList();
    // getSavedItemsList();
  }

  bool decVisible = true;
  bool get getdecVisible => decVisible;

  bool revVisible = true;
  bool get getrevVisible => revVisible;

  void toggleDec() {
    decVisible = !decVisible;
    notifyListeners();
  }

  void toggleRev() {
    revVisible = !revVisible;
    notifyListeners();
  }

  void measurementState(String value) {
    _getMeasurement = value;
    notifyListeners();
  }

  void clearMeasurement() {
    _getMeasurement = null;
    notifyListeners();
  }

  Future<List<ProductModel>> findProductByCategory(String categoryID) async {
    print('this is product id $categoryID');
    try {
      var response =
          await api.productSearch(categoryID, "/public/products-search");
      var result = json.decode(response.body.toString());
      print(result);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data']['results'] as List;
        _getProductCategory =
            list.map((e) => ProductModel.fromJson(e)).toList();
      }
      return _getProductCategory;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await api.getCategory();
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
        // return false;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getCategories = list.map((e) => CategoryModel.fromJson(e)).toList();
        notifyListeners();
      }
      return _getCategories;
    } catch (exception) {
      // print('tis is vcatgoeitr $exception');
      return null;
    }
  }

  Future<List<UnitModel>> getUnit() async {
    try {
      var response = await api.getUnit();
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getUnits = list.map((e) => UnitModel.fromJson(e)).toList();
      }
      return _getUnits;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  // ignore: missing_return
  Future<List<ProductModel>> getproductBestDeals() async {
    try {
      var response = await api.getProduct("/public/best-deals-products");

      var result = json.decode(response.body);
      // print('this is reuslt ${result} from featured');
      if (response.statusCode != 200) {
        return null;
      }
      var list = result['data'] as List;
      _getProductBestDeal = list.map((e) => ProductModel.fromJson(e)).toList();
      return _getProductBestDeal;
    } catch (exception) {
      print('this is reuslt $exception from featured');
      return null;
    }
  }

  Future<List<ProductModel>> getproductTopDeals() async {
    try {
      var response = await api.getProduct("/public/top-selling-products");
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getProductTopSelling =
            list.map((e) => ProductModel.fromJson(e)).toList();
      }
      return _getProductTopSelling;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<List<ProductAllTopModel>> getAllproductTopDeals() async {
    try {
      var response = await api.getProduct("/public/top-selling-products/all");
      var result = json.decode(response.body);
      // print(result);
      if (response.statusCode != 200) {
        return null;
      }
      print('this is all Top selling ${result['data']}');
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getAllProductTopSelling =
            list.map((e) => ProductAllTopModel.fromJson(e)).toList();
      }
      return _getAllProductTopSelling;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<List<ProductAllBestModel>> getAllproductBestDeals() async {
    try {
      var response = await api.getProduct("/public/best-deals-products/all");
      var result = json.decode(response.body);
      // print(result);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;

        _getAllProductBestDeal =
            list.map((e) => ProductAllBestModel.fromJson(e)).toList();
      }
      return _getAllProductBestDeal;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<List<FaqModel>> getFaqies() async {
    try {
      var response = await api.getFaq();
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        // print('this is from faq $list');
        _getFaq = list.map((e) => FaqModel.fromJson(e)).toList();
      }
      return _getFaq;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<bool> savedWhistList(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.savedProduct(authToken, productId);
      print(responseJson.statusCode);
      if (responseJson.statusCode != 200) {
        return false;
      }
      // if(responseJson.statusCode == 200)
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<List<WhistlistModel>> getSavedItemsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.getData(authToken, "/user/wishlist/list");
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getSavedItem = list.map((e) => WhistlistModel.fromJson(e)).toList();
        notifyListeners();
      }
      return _getSavedItem;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<bool> removeItem(String whistlistId) async {
    // print('Provider id $whistlistId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var response = await api.deleteData(authToken, whistlistId);
    print('Provider id ${response.body}');
    if (response.statusCode != 200) {
      return false;
    }
    print(response.statusCode);
    return true;
  }

  Future<List<ProductModel>> searchByFilter(
      int catId, freshness, minPrice, maxPrice, rating) async {
    print(
        'cat id $catId, freshness $freshness and minPrice $minPrice, and maxprice $maxPrice and rating $rating');
    try {
      var response =
          await api.filterSearch(catId, freshness, rating, minPrice, maxPrice);
      var result = json.decode(response.body);
      print('this is filter $result');
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data']['results'] as List;
        _getProductFilter = list.map((e) => ProductModel.fromJson(e)).toList();
      }
      return _getProductFilter;
    } catch (exception) {
      print('thius is exfeption from filter $exception');
      return null;
    }
  }

  Future<List<ProductModel>> searchByproduct(String productname) async {
    try {
      var response = await api.filterbySearch(productname);
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data']['results'] as List;
        _getProductFilter = list.map((e) => ProductModel.fromJson(e)).toList();
      }
      return _getProductFilter;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  // ignore: missing_return
  Future<List<ProductModel>> getRecentlyView(int productId) async {
    // print('hello $productId');
    try {
      var response = await api.recentlyView(productId);
      print(response.statusCode);
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      print('this is Recent $result');
      // if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getRecentView = list.map((e) => ProductModel.fromJson(e)).toList();
      // }
      return _getRecentView;
      // });

    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  List<ProductModel> _items = [];

  List<ProductModel> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(int productId, List model) {
    if (_items.map((e) => e.id).contains(productId)) {
      return;
    } else {
      print(_items.map((e) => e.id));
      _items.addAll(model.where((id) => id.id == productId));
    }
    notifyListeners();
  }

  ReviewProductState _reviewProductState = ReviewProductState.initial;
  ReviewProductState get reviewProductState => _reviewProductState;
  String _commentError;
  String get commentError => _commentError;

  Future<bool> reviewProducts(String productId, comment, stars) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token').toString();
      _reviewProductState = ReviewProductState.loading;
      notifyListeners();
      var response = await api.reviewProduct(token, productId, comment, stars);
      final responseJson = json.decode(response.body);
      print('this is product review add $responseJson');
      if (response.statusCode == 200) {
        _reviewProductState = ReviewProductState
            .complete; // When User Touches the Sign Up Button, it will Load
        notifyListeners();
        return true;
      }
      print('this is error message ${responseJson['message']}');
      _commentError = responseJson['message'];
      _reviewProductState = ReviewProductState
          .error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
    } catch (exception) {
      // print('this is get User Detail $exception');
      _reviewProductState = ReviewProductState
          .error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
      // return null;
    }
  }
}
