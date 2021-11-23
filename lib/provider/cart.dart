import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/boarding/Welcome/welcome_screen.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/cartModel.dart';
import 'package:nuthoop/model/ordered.dart';
import 'package:nuthoop/model/createOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String imageUrl;
  final String productName;
  final int quantity;
  final double price;
  final String measurement;

  CartItem(
      {@required this.id,
      @required this.imageUrl,
      @required this.productName,
      @required this.quantity,
      @required this.price,
      this.measurement});
}

enum OrderState { error }
enum QuantityState { initial, error, loading, complete }
enum QuantityErrorState { error }
enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class CartProvider with ChangeNotifier {
  QuantityState _quantityState = QuantityState.initial;
  QuantityState get quantityState => _quantityState;

  QuantityErrorState _quantityErrorState; // Initial State of the form
  QuantityErrorState get quantityErrorState => _quantityErrorState;

  CartProvider(context) {
    getSavedCartItemsList(context);
    getOrdered();
    _quantityState = QuantityState.initial;
    _getOrderedItem = <OrderedModel>[];
    _getOrderedSingleItem = OrderedModel();
    _getCartItem = CartModel();
    _getCreateOrderDetail = CreateOrder();
    _quantity = 1;
    _address = '';
    _orderLoaded = false;
    _payWithWallet = false;
    _payWithCard = false;
    _standardDel = false;
    _pickUpSale = false;
    _orderNetwork = false;
    _expressPickUpPlace = '';
    _getExpressPickUpAddress = '';
  }

  Api api = new Api();

  OrderState _orderState; // Initial State of the form
  OrderState get orderState => _orderState;

  List<OrderedModel> _getOrderedItem = <OrderedModel>[];

  OrderedModel _getOrderedSingleItem = OrderedModel();
  OrderedModel get getOrderedSingleItem {
    return _getOrderedSingleItem;
  }

  List<OrderedModel> get getOrderedItem {
    return [..._getOrderedItem];
  }

  CartModel _getCartItem = CartModel();

  CartModel get getCartItem {
    return _getCartItem;
  }

  Map<String, CartItem> _items = {};

  // Map<String, CartItem> get items {
  //   return {...?_items};
  // }

  CreateOrder _getCreateOrderDetail = CreateOrder();
  CreateOrder get getCreateOrderDetail => _getCreateOrderDetail;

  int get itemCount {
    return _items.length;
  }

  var _quantity = 1;

  void incrementQty() {
    _quantity++;
    notifyListeners();
  }

  void decrementQty() {
    if (_quantity >= 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void clear() {
    _quantity = 1;
    notifyListeners();
  }

  setQuantity(int qty) => _quantity = qty;
  getQuantity() => _quantity;

  double _totalPrice = 0.0;
  double getTotalPrice() => _totalPrice;

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  String _address;
  String get getAddress => _address;

  void saveAddress(String address) {
    _address = address;
    notifyListeners();
  }

  bool _payWithWallet = false;
  bool get getPayWithWallet => _payWithWallet;

  void setPayWithWallet() {
    if (_payWithCard) {
      _payWithCard = false;
      notifyListeners();
    }
    _payWithWallet = !_payWithWallet;
    notifyListeners();
  }

  bool _payWithCard = false;
  bool get getPayWithCard => _payWithCard;

  void setPayWithCard() {
    if (_payWithWallet) {
      _payWithWallet = false;
      notifyListeners();
    }
    _payWithCard = !_payWithCard;
    notifyListeners();
  }

  int _totalPayout;
  int get gettotalPayout => _totalPayout;

  bool _standardDel = false;
  bool get getStandardDelivery => _standardDel;

  bool _pickUpSale = false;
  bool get getPickUpSale => _pickUpSale;

  void standardDelivery(int amount) {
    if (!_standardDel) {
      _totalPayout = amount + 500;
      _getExpressPickUpAddress = null;
      notifyListeners();
    } else {
      _totalPayout = 500 - amount;
      notifyListeners();
    }
    if (_pickUpSale) {
      _pickUpSale = false;
    }
    _standardDel = !_standardDel;
    notifyListeners();
  }

  void pickUpSale() {
    if (_standardDel) {
      _standardDel = false;
      _totalPayout -= 500;
      notifyListeners();
    }
    _pickUpSale = !_pickUpSale;
    notifyListeners();
  }

  String _expressPickUpPlace;
  String get expressPickUpPlace => _expressPickUpPlace;

  void expressPickUpVenue(value) {
    _expressPickUpPlace = value;
    notifyListeners();
  }

  String _getExpressPickUpAddress;
  String get getExpressPickUpAddress => _getExpressPickUpAddress;

  void getExpressPickUpVenue(value) {
    _getExpressPickUpAddress = value;
    notifyListeners();
  }

  String _expressPickUpPlaceArea;
  String get expressPickUpPlaceArea => _expressPickUpPlaceArea;

  void expressPickUpVenueArea(value) {
    _expressPickUpPlaceArea = value;
    notifyListeners();
  }

  String _expressPickUpPlaceAgent;
  String get expressPickUpPlaceAgent => _expressPickUpPlaceAgent;

  void expressPickUpVenueAgent(value) {
    _expressPickUpPlaceAgent = value;
    notifyListeners();
  }

  Future<bool> orders(
      context, String addressId, paymentMode, orderNote, deliveryNote) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.orders(
          authToken, addressId, paymentMode, orderNote, deliveryNote);
      var data = json.decode(responseJson.body);
      // print(responseJson.statusCode);
      // refresh token
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401 ||
            responseState.statusCode == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
        if (res['status_code'] == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
        _orderState = OrderState
            .error; // When User Touches the Sign Up Button, it will Load
        return false;
      }
      if (responseJson.statusCode != 200) {
        _orderState = OrderState
            .error; // When User Touches the Sign Up Button, it will Load;
        return false;
      }
      var result = data['data'];
      _getCreateOrderDetail = CreateOrder.fromJson(result);
      return true;
    } catch (exception) {
      // print(exception);
      return false;
    }
  }

  Future<bool> addCart(
      context, String productId, unitId, int qty, double price) async {
    print(
        'this is product id $productId and this unit ID $unitId the this is $qty and price $price');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.cart(authToken, productId, unitId, qty);
      var res = json.decode(responseJson.body);
      print('add to cart response $res');
      // print('add to cart response  code ${responseJson.statusCode}');
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return false;
        }
        if (res['status_code'] == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return false;
        }
      }
      if (responseJson.statusCode != 200) {
        return false;
      }
      if (responseJson.statusCode == 200) notifyListeners();
      return true;
    } catch (exception) {
      print('this is add to cart exception $exception');
      return false;
    }
  }

  getSavedCartItemsList(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.getData(authToken, "/user/cart/list-with-total");
      var result = json.decode(response.body);
      print('data from cart list ${response.statusCode}');
      if (response.statusCode == 200) {
        _getCartItem = CartModel.fromJson(result);
        notifyListeners();
      }
      // print(authToken);
      if (response.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
        if (res['status_code'] == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
      }
    } catch (exception) {
      print('this si exception from cart lkist $exception');
      return null;
    }
  }

  setTotal(int qty, double price) {
    return _totalPrice = _totalPrice + price * double.parse(qty.toString());
  }

  bool ready;
  bool get getReady => ready;

  Future<bool> updateCart(int cartId, qty, productId) async {
    try {
      ready = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson =
          await api.updateCartProduct(authToken, cartId, qty, productId);
      // ignore: unused_local_variable
      var data = json.decode(responseJson.body);
      print('It is update $data');
      if (responseJson.statusCode == 401) {
        _quantityState = QuantityState.error;
        _quantityErrorState = QuantityErrorState.error;
        return false;
      }
      if (responseJson.statusCode != 200) {
        _quantityState = QuantityState.error;
        _quantityErrorState = QuantityErrorState.error;
        return false;
      }
      if (responseJson.statusCode == 200)
        _quantityState = QuantityState.complete;
      // notifyListeners();
      return true;
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<bool> deleteCart(int cartId, context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.deleteCartProduct(authToken, cartId);
      var data = json.decode(responseJson.body);
      print('data has been deleted $data');
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401 ||
            responseState.statusCode == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
        if (res['status_code'] == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }
      }
      if (responseJson.statusCode != 200) {
        return false;
      }
      // print(responseJson.statusCode);
      notifyListeners();
      return true;
    } catch (exception) {
      // print(exception);
      return false;
    }
  }

  bool _orderLoaded = false;
  bool get orderLoaded => _orderLoaded;

  String _orderNetworkString;
  String get orderNetworkString => _orderNetworkString;

  bool _orderNetwork = false;
  bool get orderNetwork => _orderNetwork;
// Get Ordered Detail List
  Future<List<OrderedModel>> getOrdered() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _orderLoaded = false;
        notifyListeners();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.getData(authToken, "/user/orders/list");
      var result = json.decode(response.body);
      print(authToken);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getOrderedItem = list.map((e) => OrderedModel.fromJson(e)).toList();
        _orderLoaded = true;
        notifyListeners();
      }
      return _getOrderedItem;
    } catch (exception) {
      print('exception order $exception');
      _orderNetworkString = 'exception order $exception';
      _orderNetwork = true;
      notifyListeners();
      return null;
    }
  }

// Get Ordered Detail List
  Future<OrderedModel> getSingleOrderedDetail(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.getData(authToken, "/user/orders/details/$id");
      // Map<String, dynamic> userdata =
      //     new Map<String, dynamic>.from(json.decode(response.body)['data']);
      var result = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200) {
        _getOrderedSingleItem = OrderedModel.fromJson(result['data']);
        notifyListeners();
      }

      return _getOrderedSingleItem;
    } catch (exception) {
      print('this is from single oreder exceptoion $exception');
      return null;
    }
  }

  Future compeletTransaction(String refrence) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.complateTrasaction(
          authToken, "/user/confirm-transaction", refrence);
      // ignore: unused_local_variable
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<void> logout2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    if (authToken != null) {
      prefs.remove('token');
      _quantityState = QuantityState.initial;
      _getOrderedItem = <OrderedModel>[];
      _getOrderedSingleItem = OrderedModel();
      _getCartItem = CartModel();
      _getCreateOrderDetail = CreateOrder();
      _quantity = 1;
      _address = '';
      _orderLoaded = false;
      _payWithWallet = false;
      _payWithCard = false;
      _standardDel = false;
      _pickUpSale = false;
      _orderNetwork = false;
      _expressPickUpPlace = '';
      _getExpressPickUpAddress = '';
      notifyListeners();
    }
  }
}
