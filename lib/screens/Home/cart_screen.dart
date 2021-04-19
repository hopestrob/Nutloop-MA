import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:nutloop_ecommerce/helper/api.dart';
import '../../provider/cart.dart' show Cart;
import 'widget/cart_item.dart';
import '../../helper/config_size.dart';
import 'package:nutloop_ecommerce/model/cartModel.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

 var _totalPrice;

  setTotal (int qty, double price){
      if(mounted) return;
      setState(() {
        _totalPrice = _totalPrice + price * double.parse(qty.toString());
      });
  return  _totalPrice;
}

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context, listen: false);
    //  
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: 
      // cart.items.isEmpty
      //     ? Column(
      //         children: [
      //           Container(
      //             margin: EdgeInsets.all(8.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Center(
      //                   child: Text('My Cart',
      //                       style: TextStyle(
      //                           color: kPrimaryColor,
      //                           fontSize: 20.0,
      //                           fontWeight: FontWeight.bold)),
      //                 ),
                      
      //               ],
      //             ),
      //           ),
      //           // Spacer(),
      //           line(context),
      //           SizedBox(height: size.height * 0.150),
      //           Expanded(
      //             flex: 1,
      //             child: Text('Your Cart is Empty', style: TextStyle(fontSize: 20.0),),
      //           ),
      //              Expanded(
      //                flex:3,
      //                                   child: SvgPicture.asset(
      //                 "asset/cart.svg",
      //                 height: size.width * 0.330,
      //                 color: kBrandColor,
      //             ),
      //              ),
      //             // SizedBox(height: size.height * 0.150),
      //             Container(
      //                 margin: EdgeInsets.all(5.0 * SizeConfig.widthMultiplier),
      //                   width: 95 * SizeConfig.widthMultiplier,
      //                 padding: EdgeInsets.all(10.0),
      //                 // width: size.width / 1.2,
      //                 decoration: BoxDecoration(
      //                 color: kPrimaryColor,
      //                 borderRadius: BorderRadius.circular(5.0)),
      //                 child: FlatButton(
      //               onPressed: ()async {
      //                         SharedPreferences prefs = await SharedPreferences.getInstance();
      //                           var authNames = prefs.getString('authName');
      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(authName: authNames)));
      //               },
      //               child: Text(
      //                 'Start Shopping',
      //                 style: TextStyle(color: Colors.white),
      //               ),
      //                 ),
      //           ),
      //           SizedBox(height: size.height * 0.020),
      //         ],
      //       )
      //     : 
      Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "My Cart",
                          style: TextStyle(
                              fontSize: 20,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      OrderButton()
                    ],
                  ),
                ),
               SizedBox(height: size.height * 0.010),
                Divider(
                  color: Colors.grey,
                  height: 1.0,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 5.0, top: 10.0),
                      child: Row(
                        children: [
                          // Consumer<Cart>(
                          //   builder: (_, cartObject, child) => Text(
                          //       "${cartObject.items.data.length}items: Total(Excluding delivery charges)",
                          //       style:
                          //           TextStyle(fontSize: 13, color: greyColor3)),
                          // ),
                          Consumer<Cart>(
                            builder: (_, cartObject, child) => Text(
                                "${cartObject.getTotalPrice()}",
                                style:
                                    TextStyle(fontSize: 13, color: greyColor3)),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: Consumer<Cart>(
                      builder: (_, savedCartItem, child){
                      // Provider.of<Cart>(context, listen:false).
                      // savedCartItem.getSavedCartItemsList();
                     return   ListView.builder(
                      itemBuilder: (_, index) { 
                         var image = json.decode(savedCartItem.items.data[index].product.images);

                        //  var unitName = savedCartItem.items[index].product.prices;
                        //  print(double.parse(savedCartItem.items[index].product.prices.where((e) => e.unitId == savedCartItem.items[index].unit.id).map((e) => e.priceRegular).join()),);
                        // for(int i = 0; i < cart.items.length; i++){
                        //    subTotal = subTotal + double.parse(savedCartItem.items[index].product.prices.where((e) => e.unitId == savedCartItem.items[index].unit.id).map((e) => e.priceRegular).join());
                        //   print('This is SubTotal $subTotal');
                        // working below
                        //  double  subTotal2 = double.parse(savedCartItem.items.data[index].product.prices.where((e) => e.unitId == savedCartItem.items.data[index].unit.id).map((e) => e.priceRegular).toList().reduce((value, current) => value + savedCartItem.items.data[index].quantity.toString() * int.parse(current)));
                        //  double  subTotal2 = savedCartItem.items[index].product.prices.where((e) => e.unitId == savedCartItem.items[index].unit.id).map((e) => e.priceRegular).toList().fold(100.0, (previousValue, current) => savedCartItem.items[index].quantity * double.parse(current));
                        // var singlePrice = savedCartItem.items.data.map((e) => e.id);
                        // var cartId = savedCartItem.items.data.map((e) => e.id).toList();
                        // print('This is Cart Id $cartId from widget');
                        // var single = 
                        var qnty = savedCartItem.items.data.where((e) => e.id == 239).map((e) => e.quantity).toList().join();
                         var priceId = savedCartItem.items.data.where((e) => e.id == 239).map((e) => e.priceId).toList().join();
                         var unitId = savedCartItem.items.data.where((e) => e.id == 239).map((e) => e.mUnitId).toList().join();
                         double getPrice = double.parse(savedCartItem.items.data.where((e) => e.id == 239).map((e) => e.product.prices
                         .where((e) => e.unitId == int.parse(unitId)).where((e) => e.id == int.parse(priceId)).map((e) => e.priceRegular).join()).join());
                        //  print('this is Price ID $priceId');
                         print('this is Quantity ID $qnty');
                         print('this is Price ID $getPrice');
                        //   double result =  savedCartItem.setTotal(qty, subTotal2);
                        //   List value;
                          // totals.add(subTotal2);
                        //  print('This is subTotal ${totals.reduce((a, b) => a+b)}');
                         
                        //  print('This is total $result from widget');
                        //  print('This is subtotal $result from widget');
                        print('this is cart id ${savedCartItem.items.data[index].id}');
                        print(savedCartItem.items.data.where((e) => e.id == savedCartItem.items.data[index].id).map((e) => e.product.prices.where((e) => e.unitId == int.parse(unitId)).where((e) => e.id == int.parse(priceId)).map((e) => e.priceRegular).join()).join());
                        // print(savedCartItem.items.data[index].id);
                    //  Future.delayed(Duration.zero, () async {
                    
                        return CartItem(
                          savedCartItem.items.data[index].id.toString(),
                          savedCartItem.items.data[index].productId.toString(),
                          "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                          // double.parse(savedCartItem.items.data[index].product.prices.where((e) => e.unitId == savedCartItem.items.data[index].unit.id).map((e) => e.priceRegular).join()),
                          double.parse(savedCartItem.items.data.where((e) => e.id == savedCartItem.items.data[index].id).map((e) => e.product.prices.where((e) => e.unitId == savedCartItem.items.data[index].mUnitId).where((e) => e.id == savedCartItem.items.data[index].priceId).map((e) => e.priceRegular).join()).join()),
                          savedCartItem.items.data[index].quantity,
                          savedCartItem.items.data[index].product.name,
                          savedCartItem.items.data.where((prod) => prod.id == savedCartItem.items.data[index].id).map((e) => e.product.prices.where((e) => e.unitId == savedCartItem.items.data[index].unit.id).map((e) => e.unit.abbreviation)).join(),
                          savedCartItem.items.data[index].product.prices.where((e) => e.unitId == savedCartItem.items.data[index].unit.id).map((e) => e.unit.abbreviation).join(),
                          setTotal(int.parse(savedCartItem.items.data.where((e) => e.id == savedCartItem.items.data[index].id).map((e) => e.quantity).toList().join()), double.parse(savedCartItem.items.data.where((e) => e.id == savedCartItem.items.data[index].id).map((e) => e.product.prices.where((e) => e.unitId == savedCartItem.items.data[index].mUnitId).where((e) => e.id == savedCartItem.items.data[index].priceId).map((e) => e.priceRegular).join()).join()))
                         );
                        // });
                   
                         },
                      itemCount: savedCartItem.items.data.length,
                      );})
                  ),
              ],
            ),
    ));
  }
}

class OrderButton extends StatefulWidget {
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
   final CartModel carts = CartModel();
  @override
  Widget build(BuildContext context) {
    return Container(
            width: 150,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: FlatButton(
                onPressed: () {
                  // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //     builder: (context) => CheckOutPage(
                      //           cartId: carts.id,
                      //           productid: carts.productId,
                      //           productUnit: carts.unit.id,
                      //           productQuantity: carts.quantity,
                      //         )));
                },
                child: Text(
                  "Check out",
                  style: TextStyle(color: Colors.white),
                )));
  }
}
