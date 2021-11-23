import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static String imageUrl = "https://api.nuthoop.com/uploads/";
  static String serverUrl = "https://api.nuthoop.com/api";
  // http://api.nuthoop.com/api

  // static String imageUrl = "http://nutloop.tk/uploads/";
  // static String serverUrl = "http://nutloop.tk/api";
  //   static String imageUrl = "http://3.137.187.51/uploads/";
  // String serverUrl = "http://3.137.187.51/api";

  // User Registration Api settings
  registerData(
      String name, email, password, passwordConfirmation, phoneNumber) async {
    String myUrl = "$serverUrl/user/signup";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "password_confirmation": "$passwordConfirmation",
      "phone_number": "$phoneNumber"
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// Social Signup Api Setting
  socialSignUp(String name, email, socialProviderId, socialProvider) async {
    String myUrl = "$serverUrl/user/social-signup";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "name": "$name",
      "email": "$email",
      "social_provider_id": "$socialProviderId",
      "social_provider": "$socialProvider",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// Social Signup Api Setting
  socialSignIn(String socialProviderId, socialProvider) async {
    String myUrl = "$serverUrl/user/auth/social-login";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "social_provider_id": "$socialProviderId",
      "social_provider": "$socialProvider",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// User Login Api Setting
  loginData(String email, String password) async {
    String myUrl = "$serverUrl/user/auth/login";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "email": "$email",
      "password": "$password",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

//Reset Password
  resetPassword(String token, email) async {
    String myUrl = "$serverUrl/user/forgot-password";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "email": "$email",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

  // User Change Password Api Setting
  changePassword(String token, oldPassword, newPassword, conNewPassword) async {
    String myUrl = "$serverUrl/user/change-password";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "old_password": "$oldPassword",
      "new_password": "$newPassword",
      "new_password_confirmation": "$conNewPassword",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// User Add Address
  addAddress(String token, firstName, lastName, phone, mobile, houseNo, street,
      area, city, deliverNote) async {
    String myUrl = "$serverUrl/user/addresses-book/create";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "first_name": "$firstName",
      "last_name": "$lastName",
      "phone_number": "$phone",
      "mobile_number": "$mobile",
      "house_no": "$houseNo",
      "street": "$street",
      "area": "$area",
      "city": "$city",
      "delivery_instructions": "$deliverNote",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// User Update Address
  updateAddress(int id, String token, firstName, lastName, phone, mobile,
      houseNo, street, area, city, deliverNote) async {
    String myUrl = "$serverUrl/user/addresses-book/update/$id";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "first_name": "$firstName",
      "last_name": "$lastName",
      "phone_number": "$phone",
      "mobile_number": "$mobile",
      "house_no": "$houseNo",
      "street": "$street",
      "area": "$area",
      "city": "$city",
      "delivery_instructions": "$deliverNote",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// Get Category info Api settings

  getCategory() async {
    String myUrl = "$serverUrl/public/categories";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

//Get Unit Measurement
  getUnit() async {
    String myUrl = "$serverUrl/public/units";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

  // Get Faq info Api settings

  getFaq() async {
    String myUrl = "$serverUrl/public/faqs";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

  getProduct(String url) async {
    String myUrl = "$serverUrl" + "$url";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

//get Product by Category id
  productSearch(String categoryId, String url) async {
    String myUrl = "$serverUrl" + "$url";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "category_id": "$categoryId",
    });
    final response = await http.put(myUrl, headers: headers, body: body);
    return response;
  }

//get Product by Category id
  savedProduct(String token, productId) async {
    String myUrl = "$serverUrl/user/wishlist/create";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "product_id": "$productId",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// Get User info Api settings

  getData(String token, url) async {
    String myUrl = "$serverUrl" + "$url";

    print('this si url $myUrl');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

//get  Profile by Token
  getProfile(String token, url) async {
    String myUrl = "$serverUrl" + "$url";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(myUrl, headers: headers);
    return response;
  }

//get  Profile by Token
  refreshToken(String token) async {
    String myUrl = "$serverUrl/user/auth/refresh";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.post(myUrl, headers: headers);
    return response;
  }

  // Update Profile by Token
  updateProfile(String token, name, email, phone) async {
    String myUrl = "$serverUrl/user/update-profile";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      "name": "$name",
      "email": "$email",
      "phone_number": "$phone",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// Delete Item
  deleteData(String token, whistListId) async {
    // print(whistListId);
    String myUrl = "$serverUrl/user/wishlist/delete/$whistListId";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.delete(myUrl, headers: headers);
    return response;
  }

  //Delete Item
  deleteDatas(String token, url, id) async {
    // print(whistListId);
    String myUrl = "$serverUrl/$url/$id";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.delete(myUrl, headers: headers);
    return response;
  }

// Cart Api
  cart(String token, productId, unitId, qty) async {
    String myUrl = "$serverUrl/user/cart/create";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      "product_id": "$productId",
      "m_unit_id": "$unitId",
      "quantity": "$qty",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

  //update cart
  updateCartProduct(String token, int cartId, qty, productId) async {
    String myUrl = "$serverUrl/user/cart/update/$cartId";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({"quantity": "$qty", "product_id": "$productId"});
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

// delete cart Item
  deleteCartProduct(String token, cartId) async {
    String myUrl = "$serverUrl/user/cart/delete/$cartId";
    print(myUrl);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(myUrl, headers: headers);
    return response;
  }
// Cart Api
  // updateCartQuantity(String token, qty) async{
  //   String myUrl = "$serverUrl/user/cart/update/";
  //     Map<String, String> headers = {
  //         'Accept':'application/json',
  //         'Content-type': 'application/json;charset=UTF-8',
  //         'Charset' : 'utf-8',
  //         'Content-Transfer-Encoding':'application/x-www-form-urlencoded',
  //          'Authorization' : 'Bearer $token',
  //       };
  //   final body = jsonEncode({
  //         "quantity": "$qty",
  //   });
  //   final response = await  http.post(myUrl,
  //       headers: headers,
  //       body: body ) ;
  //   return response;

  // }
// To Send Code to User Api Setting
  orders(String token, addressId, paymentMode, orderNote, deliveryNote) async {
    String myUrl = "$serverUrl/user/orders/create";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      "address_id": "$addressId",
      "payment_mode": "$paymentMode",
      "order_notes": "$orderNote",
      "delivery_mode": "$deliveryNote",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }
// filter search

  filterSearch(int catId, freshness, rating, int minPrice, maxPrice) async {
    String myUrl = "$serverUrl/public/products-search";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
    };
    final body = jsonEncode({
      "category_id": catId,
      "min_price": minPrice,
      "max_price": maxPrice,
      "freshness": freshness,
    });
    print(body);
    final response = await http.put(myUrl, headers: headers, body: body);
    return response;
  }

  filterbySearch(String product) async {
    String myUrl = "$serverUrl/public/products-search";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
    };
    final body = jsonEncode({
      "product_name": "$product",
    });
    final response = await http.put(myUrl, headers: headers, body: body);
    return response;
  }

  // Profile by Token
  complateTrasaction(String token, url, refrence) async {
    String myUrl = "$serverUrl" + "$url";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "refrence": "$refrence",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

  // Update Profile by Token
  recentlyView(int productId) async {
    String myUrl = "$serverUrl/public/multiple-products-details";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded',
    };
    List recentView = [];
    recentView.add(productId);
    final body = jsonEncode({
      "products": recentView,
    });
    print(body);
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

  getProductDetails(int id) async {
    String myUrl = "$serverUrl/public/product-details/$id";
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    http.Response response = await http.get(myUrl, headers: headers);
    return response;
  }

  // User Change Password Api Setting
  reviewProduct(String token, productId, comment, stars) async {
    String myUrl = "$serverUrl/user/review-product";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "product_id": "$productId",
      "comment": "$comment",
      "stars": "$stars",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }

  // Send Contact
  sendContact(
      String token, name, email, phoneNumber, message, subjectid) async {
    String myUrl = "$serverUrl/public/contact-us";

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
      'Authorization': 'Bearer $token',
      'Content-Transfer-Encoding': 'application/x-www-form-urlencoded'
    };
    final body = jsonEncode({
      "name": "$name",
      "email": "$email",
      "phone_number": "$phoneNumber",
      "message": "$message",
      "subject_id": "$subjectid",
    });
    final response = await http.post(myUrl, headers: headers, body: body);
    return response;
  }
}
