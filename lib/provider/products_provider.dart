import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/category_model.dart';
import 'package:nutloop_ecommerce/model/faqModel.dart';
import 'package:nutloop_ecommerce/model/products.dart';
import 'package:nutloop_ecommerce/model/whistList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider with ChangeNotifier {
  Api api = new Api();
  List<CategoryModel> _getCategories = List<CategoryModel>();
  List<FaqModel> _getFaq = List<FaqModel>();
  List<ProductModel> _getProductBestDeal, _getProductTopSelling,_getProductCategory, _getAllProductTopSelling, _getAllProductBestDeal = List<ProductModel>();
  List<WhistlistModel> _getSavedItem = List<WhistlistModel>();

 List<FaqModel> get getFaq {
    return [...?_getFaq];
  }

  List<CategoryModel> get getCategoy {
    return [...?_getCategories];
  }

  List<ProductModel> get getProductBestDeal {
    return [...?_getProductBestDeal];
  }

   List<ProductModel> get getProductTopSelling {
    return [...?_getProductTopSelling];
  }

    List<ProductModel> get getProductCategory {
    return [...?_getProductCategory];
  }


  List<ProductModel> get getAllProductTopSelling {
    return [...?_getAllProductTopSelling];
  }

    List<ProductModel> get getAllProductBestDeal {
    return [...?_getAllProductBestDeal];
  }


   List<WhistlistModel> get getSavedItem {
    return [...?_getSavedItem];
  }

  String _getSavedImage;
  String get getSavedImage => _getSavedImage;

  String _getImageDeal;
  String get getImageDeal => _getImageDeal;

  String _getImageTopSelling;
  String get getImageTopSelling => _getImageTopSelling;

  String _getProductcatImage;
  String get getProductcatImage => _getProductcatImage;


  String _getImageAllTopSelling;
  String get getImageAllTopSelling => _getImageAllTopSelling;

  String _getAllProductBestDealImage;
  String get getAllProductBestDealImage => _getAllProductBestDealImage;


  String _getpriceRegular;
  String get getpriceRegular => _getpriceRegular;


  String _getMeasurement;
  String get getMeasurement => _getMeasurement;

   setMeasurement(String measure){
    _getMeasurement = measure;
        notifyListeners();
  }



  ProductsProvider() {
    getCategories();
    getproductBestDeals();
    getproductTopDeals();
    getAllproductTopDeals();
    getFaqies();
    getSavedItemsList();
  }


   bool decVisible = true;
   bool get getdecVisible => decVisible;

   bool revVisible = true;
   bool get getrevVisible => revVisible;

   void toggleDec(){
       decVisible = !decVisible;
       notifyListeners();
             
   }

     void toggleRev(){
       revVisible = !revVisible;
       notifyListeners();
             
   }

   void measurementState(String value){
     _getMeasurement = value;
     notifyListeners();
   }


   

Future<List<ProductModel>> findProductByCategory(String categoryID) async
{
    // try{
    var response = await api.productSearch(categoryID,"/public/products-search");
    var result = json.decode(response.body.toString());
    // print(result);
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
        print(result['data']['results']);
    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data']['results'] as List;
      _getProductCategory = list.map((e) => ProductModel.fromJson(e)).toList();
      var productCatImages = _getProductCategory.map((e) => e.images).toList();
      for (var item in productCatImages) {
        var val = jsonDecode(item).toList();
        for (var items in val) {
          _getProductcatImage = items.toString();
          notifyListeners();
        }
      }
      notifyListeners();
    }
    print(_getProductCategory.map((e) => e.categoryId));
    return _getProductCategory;
  //  } catch (exception) {
  //       print(exception);
  //   return null;
  // }

}


  Future<List<CategoryModel>> getCategories() async {
    try{
    var response = await api.getCategory();
    var result = json.decode(response.body);
    if (response.statusCode != 200) {
      notifyListeners();
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
        print(exception);
    return null;
  }
  }


  Future<List<ProductModel>> getproductBestDeals() async {
    try{
    var response = await api.getProduct("/public/best-deals-products");
    var result = json.decode(response.body);
    print(result);
    if (response.statusCode != 200) {
      notifyListeners();
       return null;
      // return false;
    }

    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getProductBestDeal = list.map((e) => ProductModel.fromJson(e)).toList();
      var bestDealImages = _getProductBestDeal.map((e) => e.images).toList();
      for (var item in bestDealImages) {
        var val = jsonDecode(item).toList();
        for (var items in val) {
          _getImageDeal = items.toString();
          notifyListeners();
          // print('This is best deal Images $_getImageDeal');
        }
      }
      notifyListeners();
    }
    return _getProductBestDeal;

       } catch (exception) {
        print(exception);
    return null;
  }
  }

 Future<List<ProductModel>> getproductTopDeals() async {
   try{
    var response = await api.getProduct("/public/top-selling-products");
    var result = json.decode(response.body);
    print(result);
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getProductTopSelling = list.map((e) => ProductModel.fromJson(e)).toList();
      var bestTopImages = _getProductTopSelling.map((e) => e.images).toList();
      for (var item in bestTopImages) {
        var val = jsonDecode(item).toList();
        for (var items in val) {
          _getImageTopSelling = items.toString();
          notifyListeners();
          // print('This is Top Selling Images $_getImageTopSelling');
        }
      }
      notifyListeners();
    }
    return _getProductTopSelling;
   } catch (exception) {
        print(exception);
    return null;
  }
  }
  

 Future<List<ProductModel>> getAllproductTopDeals() async {
   try{
    var response = await api.getProduct("/public/top-selling-products/all");
    var result = json.decode(response.body);
    // print(result);
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
    print(result['data']);
    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getAllProductTopSelling = list.map((e) => ProductModel.fromJson(e)).toList();
      var bestTopImages = _getAllProductTopSelling.map((e) => e.images).toList();
      for (var item in bestTopImages) {
        var val = jsonDecode(item).toList();
        for (var items in val) {
          _getImageAllTopSelling = items.toString();
          notifyListeners();
          // print('This is Top Selling Images $_getImageTopSelling');
        }
      }
      notifyListeners();
    }
    return _getAllProductTopSelling;
   } catch (exception) {
        print(exception);
    return null;
  }
  }
  
Future<List<ProductModel>> getAllproductBestDeals() async {
   try{
    var response = await api.getProduct("/public/best-deals-products/all");
    var result = json.decode(response.body);
    // print(result);
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
    print(result['data']);
    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getAllProductBestDeal = list.map((e) => ProductModel.fromJson(e)).toList();
      var bestTopImages = _getAllProductBestDeal.map((e) => e.images).toList();
      for (var item in bestTopImages) {
        var val = jsonDecode(item).toList();
        for (var items in val) {
          _getAllProductBestDealImage = items.toString();
          notifyListeners();
          // print('This is Top Selling Images $_getImageTopSelling');
        }
      }
      notifyListeners();
    }
    return _getAllProductBestDeal;
   } catch (exception) {
        print(exception);
    return null;
  }
  }
  
  Future<List<FaqModel>> getFaqies() async {
    try{
    var response = await api.getFaq();
    var result = json.decode(response.body);
    if (response.statusCode != 200) {
      notifyListeners();
       return null;
      // return false;
    }
    if (response.statusCode == 200 && result['status_code'] == 200) {
            var list = result['data'] as List;
                  print('this is faq $list');
      _getFaq = list.map((e) => FaqModel.fromJson(e)).toList();
      notifyListeners();
    }
    return _getFaq;
        } catch (exception) {
        print(exception);
    return null;
  }
  }

    bool faqRev = true;
   bool get getfaqRev => faqRev;

   void togglefaqRev(int id){
    //  var ids = _getFaq.map((e) => e.id);
    //  print(ids);
    //  if(ids ==  id){
    //    print(id);
    //  }  
    // 
      _getFaq.forEach((e) {
        // print(e.id);
        if(e.id ==  id){
         faqRev = !faqRev;
       notifyListeners(); 
     } 
      });
   
   }

   Future<bool> savedWhistList(String productId) async {
    try{
          SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.savedProduct(authToken, productId);
      print(responseJson.statusCode);
        if(responseJson.statusCode != 200){
          return false;
        }
    // if Status code is not 400 and its 200 then User has been register and save token to shared Pref
      print(responseJson.statusCode);
      if(responseJson.statusCode == 200)
       notifyListeners();
          return true;

    } catch (exception) {
        print(exception);
      return false;
  }
  }
Future<List<WhistlistModel>> getSavedItemsList() async {
   try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var response = await api.getData(authToken, "/user/wishlist/list");
    var result = json.decode(response.body);
    // print(result);
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
    print(response.statusCode);
    if (response.statusCode == 200 && result['status_code'] == 200) {
      var list = result['data'] as List;
      _getSavedItem = list.map((e) => WhistlistModel.fromJson(e)).toList();
      notifyListeners();
    }
    return _getSavedItem;
   } catch (exception) {
        print(exception);
    return null;
  }
  }
  

    Future<bool> removeItem(String whistlistId) async{
         SharedPreferences prefs = await SharedPreferences.getInstance();
        var  authToken = prefs.getString('token');
        var response = await api.deleteData(authToken, whistlistId);
        var result = json.decode(response.body);
        print(result);
         if (response.statusCode != 200) {
      notifyListeners();
      return false;
    }
        print(response.statusCode);
        if(response.statusCode == 200)
         notifyListeners();
        return true;
  }
}
