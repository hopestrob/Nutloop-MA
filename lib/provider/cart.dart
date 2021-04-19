import 'package:flutter/foundation.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/cartModel.dart';
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
      @required this.price, this.measurement});
}
enum OrderState {error}

class Cart with ChangeNotifier {

   Cart() {
    getSavedCartItemsList();
  }

  Api api = new Api();

OrderState _orderState; // Initial State of the form
 OrderState get orderState => _orderState;
CartModel _getCartItem = CartModel();

 CartModel get items {
    return _getCartItem;
  }

  Map<String, CartItem> _items = {};

  // Map<String, CartItem> get items {
  //   return {...?_items};
  // }

  int get itemCount {
    return _items.length;
  }

  var _quantity = 1;

  void incrementQty(){
    _quantity ++;
    notifyListeners();
  }

void decrementQty(){
  if(_quantity >= 1){
    _quantity --;
    notifyListeners();
    }
  }


void decrementCount(int i){
  if(_quantity >= 1){
    _quantity --;
    notifyListeners();
    }
  }


 var _counter = 0;
 get getCounter =>_counter;

//   eachCartprice(double price, int qty){
//      double result = price * qty;
//     //  notifyListeners();
//      return result;
//  }


  setQuantity(int qty) => _quantity = qty;
  getQuantity()=>_quantity;

    double _totalPrice = 0;
    getTotalPrice()=> _totalPrice;

    // _totalPrice += price * double.parse(qty.toString());
  //     print(_totalPrice);
  // 
  //  String get getMeasurement => _getMeasurement;

  // totalAmount2( double price) {
  //   var total = price *_quantity;
  //    notifyListeners();
  //   return total;
  // }
  
  //   getPrice(int cartId, priceIds, qty) {
  //   double price = 0;
  //  getCartItem.where((car) => car.id == cartId).forEach((x) {
  //        x.product.prices.where((id) => id.id == priceIds).forEach((e) { 
  //        price += double.parse(e.priceRegular) * qty;
  //       // notifyListeners();
  //       });
  //    });
  //   //  print(cartId);
  //   return price;
  //   // s.reduce((value, element) => value + element);
  //   // fold(0, (previous, current) => previous + double.parse(current))
  // }

  double get totalAmount {
    var total = 0.0;
    // var priced = _getCartItem.map((e) => e.priceId).join();
    // var price = _getCartItem.map((e) => e.product.prices.where((e) => e.id == int.parse(priced)).map((e) => e.priceRegular)).join();
    // print('this is price from total $price');
    // print('this is price id from total $priced');
    // _getCartItem.forEach((cartItem) => total += cartItem.product. *cartItem.quantity);
    return total;
  }

  


  void addItem(String productId, double price, String productName, String imageUrl, int qty, String measurement, unitId) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        productName: existingCartItem.productName,
        imageUrl: existingCartItem.imageUrl,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity + 1,
        measurement: existingCartItem.measurement
      ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              productName: productName,
              imageUrl: imageUrl,
              price: price,
              quantity: qty,
              measurement:measurement
          )
      );
      addCart(productId, unitId,  qty, price);
    }
    notifyListeners();
  }


  void updateProduct(String productId, double price, String productName) {
   if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        productName: existingCartItem.productName,
        price: existingCartItem.price,
        imageUrl: existingCartItem.imageUrl,
        quantity: existingCartItem.quantity + 1,
      ));
    }
    notifyListeners();
  }

   void updateProduct2(String productId, double price, String productName) {
   if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        productName: existingCartItem.productName,
        price: existingCartItem.price,
        imageUrl: existingCartItem.imageUrl,
        quantity: existingCartItem.quantity - 1,
      ));
    }
    notifyListeners();
  }


  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)) {
      return;
    }
    if(_items[productId].quantity > 1) {
      _items.update(productId, (existingCartItem) => CartItem(
        id: existingCartItem.id,
        productName: existingCartItem.productName,
        price: existingCartItem.price,
        imageUrl: existingCartItem.imageUrl,
        quantity: existingCartItem.quantity - 1,
      ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }



   String _address;
   String get getAddress => _address;

   void saveAddress(String address){
       _address = address;
       notifyListeners();        
   }

     String _cardNumber;
   String get getcardNumber => _cardNumber;

       String _cardName;
   String get getcardName => _cardName;

       String _cardExpiredate;
   String get getcardExpiredate => _cardExpiredate;

       String _cardCVV;
   String get getcardCVV => _cardCVV;

   void savecard(String cardNumber, cardName, cardExpiredate, cardCVV){
       _cardNumber = cardNumber;
       _cardName = cardName;
       _cardExpiredate = cardExpiredate;
       _cardCVV = cardCVV;
       notifyListeners();        
   }

    double _totalPayout;
    double get gettotalPayout =>_totalPayout;
    bool _standardDel = false;
    bool get getStandardDelivery => _standardDel;

    bool _pickUpSale = false;
    bool get getPickUpSale => _pickUpSale;

   void standardDelivery(double amount){
       if(!_standardDel){
        _totalPayout = amount + 500;
        _getExpressPickUpAddress = null;
          notifyListeners();
       }else{
        _totalPayout =  500 - amount;
         notifyListeners();
       }
       if(_pickUpSale){
         _pickUpSale = false;
       }
    _standardDel = !_standardDel;
       notifyListeners();
   }


     void pickUpSale(){
      if(_standardDel){
        _standardDel = false;
         _totalPayout -=  500;
          notifyListeners();
      }
       _pickUpSale = !_pickUpSale;
       notifyListeners();
   }

   String _expressPickUpPlace;
   String get expressPickUpPlace => _expressPickUpPlace;


   void expressPickUpVenue(value){
     _expressPickUpPlace = value;
      notifyListeners();
   }

   String _getExpressPickUpAddress;
     String get getExpressPickUpAddress => _getExpressPickUpAddress;


  void getExpressPickUpVenue(value){
     _getExpressPickUpAddress = value;
      notifyListeners();
   }


   Future<bool> orders(String addressId, paymentMode, orderNote, deliveryNote) async {
    // try{
    
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.orders(authToken, addressId, paymentMode, orderNote, deliveryNote);
    var data =  json.decode(responseJson.body);
    //  print(responseJson.statusCode);
    if(responseJson.statusCode == 401){
      print('Errors from there that is 400 $data');
            _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
        return false;
          }
    if(responseJson.statusCode != 200){
    print('Errors from there is that is not 200 $data');
           _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
    }
      print(responseJson.statusCode);
      notifyListeners();
      return true;
  

    // } catch (exception) {
    //   print(exception);
    // _loginstate = LoginState.error;
    //  _loginError = LoginError.otherErrors;
    //   notifyListeners();
    //   return false;
  // }
}


 Future<bool> addCart(String productId, unitId, int qty, double price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.cart(authToken, productId, unitId, qty);
    var data =  json.decode(responseJson.body);
     print(responseJson.statusCode);
    if(responseJson.statusCode == 401){
      print('Cart Errors from there that is 400 $data');
            // _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
        return false;
          }
    if(responseJson.statusCode != 200){
    print('Cart Errors from there is that is not 200 $data');
          //  _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
    }
      print(responseJson.statusCode);
      _totalPrice = price * double.parse(qty.toString());
      // print(_totalPrice);
       print('Successful data entered from there is that  200 $data');
      notifyListeners();
      return true;
  // }

    // } catch (exception) {
    //   print(exception);
    // _loginstate = LoginState.error;
    //  _loginError = LoginError.otherErrors;
    //   notifyListeners();
    //   return false;
  // }
}


Future<CartModel> getSavedCartItemsList() async {
  //  try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var response = await api.getData(authToken, "/user/cart/list");
    var result = json.decode(response.body);
    // print('This is Cart result $result');
    if (response.statusCode != 200) {
      notifyListeners();
      return null;
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      _getCartItem = CartModel.fromJson(result);
      notifyListeners();
    }

   

// var cartId = _getCartItem.map((e) => e.id).toSet();
// var cartId2 = _getCartItem.forEach((e) => e.id);
// var qties = _getCartItem.map((e) => e.quantity).toSet();
// var pricIds = _getCartItem.map((e) => e.priceId).toList();
// var prices = _getCartItem.map((e) => e.product.prices.map((e) => e.priceRegular)).toList();
// var las = _getCartItem.where((cart) => cart.id == cartId).map((e) => e.quantity).join();
// var regPrice = _getCartItem.where((cart) => cart.id == cartId).map((e) => e.product.prices.map((e) => e.priceRegular).join()).join();

// print('this cart Id $cartId');
// print('this is qty $qties');
// print('this is price List $prices');
// print('this ois last price $las');
// print('this is regular price $regPrice');
// print('this is price Id $pricIds');

// working part
    // _getCartItem.forEach((cartItems) {
    //   var priceId = cartItems.priceId;
    //       print('The price Id is ${cartItems.priceId}');
    // var price = cartItems.product.prices.map((e) => e.priceRegular).toList();
    // var price2 = cartItems.product.prices.map((e) => e.priceRegular);
    // var qty = cartItems.quantity;
    //  var totals = price.fold(0, (previous, current) => previous + qty *double.parse(current));
    //  print('this is the first Qyt $qty');
    //  print('this is the first Price $price2');
    //   print('This is the total Price ${totals.toString()}');

    // });
   
  //   _getCartItem.forEach((cartItems) {
  //     var priceId = cartItems.priceId;
  // var sum =  _getCartItem.toSet().toList().map((e){
  //     return [e.product.prices.map((e) => e.priceRegular), _getCartItem.where((element) => element.priceId == priceId).toList().length];
  //   }).reduce((a, b) => a+b);
  //     print(sum);
  //   });

    return _getCartItem;
  //  } catch (exception) {
  //       print(exception);
  //   return null;
  // }
  }
  

  Future<bool> updateCart(String cartId, qty) async {
    // try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.updateCartProduct(authToken, cartId, qty);
     var data =  json.decode(responseJson.body);
    print('This is Cart result $data');
    if(responseJson.statusCode == 401){
      notifyListeners();
        return false;
          }
    if(responseJson.statusCode != 200){
  
      notifyListeners();
      return false;
    }
      notifyListeners();
      return true;
}


 Future<bool> deleteCart(String cartId) async {
    // try{
    
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.deleteCartProduct(authToken, cartId);
    var data =  json.decode(responseJson.body);
    if(responseJson.statusCode == 401){
      print('Cart Errors from there that is 400 $data');
            // _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
        return false;
          }
    if(responseJson.statusCode != 200){
    print('Cart Errors from there is that is not 200 $data');
          //  _orderState = OrderState.error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
    }
      print(responseJson.statusCode);
       print('Successful data entered from there is that  200 $data');
       // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return true;
}

}
