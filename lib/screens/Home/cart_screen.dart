import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/model/cartModel.dart';
// import 'package:nutloop_ecommerce/model/cartModel.dart';
// import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/cart.dart';
import 'checkOutAddCard.dart';
import 'checkout.dart';
import 'homepage.dart';
import 'widget/progressdialog.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // CartProvider cartProvider;
  // @override
  // void didChangeDependencies() {
  //   Provider.of<CartProvider>(context, listen: false).getSavedCartItemsList();
  //   cartProvider = Provider.of<CartProvider>(context, listen: false);
  //   super.didChangeDependencies();
  // }

  // @override
  // void initState() {
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   Provider.of<CartProvider>(context, listen: false).getSavedCartItemsList();
  //   // });
  //   super.initState();
  // }

  // @override
  // void deactivate() {
  //   Provider.of<CartProvider>(context, listen: false).dispose();
  //   super.deactivate();
  // }
  // // @override
  // void dispose() {
  //   cartProvider.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final cart.getCartItem = Provider.of<CartModel>(context);
    // final getCartItem = Provider.of<CartProvider>(context).getCartItem;
    // final getCartItem = Provider.of<CartModel>(context);
    // print(getCartItem.data.items.length);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Consumer<CartProvider>(
              builder: (_, cart, child) =>
                  cart.getCartItem?.data?.items?.length == null
                      ? Center(
                          child: CupertinoActivityIndicator(
                          radius: 12,
                        ))
                      : cart.getCartItem?.data?.items?.length == 0
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text('My Cart',
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                line(context),
                                SizedBox(height: size.height * 0.150),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Your Cart is Empty',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SvgPicture.asset(
                                    "asset/cart.svg",
                                    height: size.width * 0.330,
                                    color: kBrandColor,
                                  ),
                                ),
                                // SizedBox(height: size.height * 0.150),
                                Container(
                                  margin: EdgeInsets.all(
                                      5.0 * SizeConfig.widthMultiplier),
                                  width: 95 * SizeConfig.widthMultiplier,
                                  padding: EdgeInsets.all(10.0),
                                  // width: size.width / 1.2,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      var authNames =
                                          prefs.getString('authName');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Homepage(
                                                  authName: authNames)));
                                    },
                                    child: Text(
                                      'Start Shopping',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.020),
                              ],
                            )
                          :
                          // Consumer<CartProvider>(
                          //     builder: (_, cart, child) =>
                          Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "My Cart",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      OrderButton(
                                          cartIdLength: cart
                                              .getCartItem?.data?.items?.length,
                                          totalAmount:
                                              Provider.of<CartProvider>(context)
                                                      .getCartItem
                                                      .data
                                                      ?.total ??
                                                  0)
                                      // OrderButton(cartIdLength: cart.getCartItem.data?.items?.length, totalAmount:Provider.of<CartProvider>(context).getCartItem.data?.total ?? 0)
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
                                          Text(
                                              "${cart.getCartItem?.data?.items?.length ?? 0} items: Total(Excluding delivery charges)",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: greyColor3)),
                                          Text(
                                              "N${cart.getCartItem?.data?.total ?? 0.0}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: kBrandColor)),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    child:
                                        // Consumer<CartProvider>(
                                        //     builder: (_, savedCartItem, child) =>
                                        ListView.builder(
                                            itemCount: cart.getCartItem?.data
                                                    ?.items?.length ??
                                                0,
                                            itemBuilder: (_, index) {
                                              var image = json.decode(cart
                                                  .getCartItem
                                                  .data
                                                  .items[index]
                                                  .product
                                                  .images);
                                              // print(image);
                                              final prod = cart.getCartItem.data
                                                  .items[index].product;
                                              return Card(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15.0),
                                                              width: 120,
                                                              height: 120,
                                                              child:
                                                                  Image.network(
                                                                "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                loadingBuilder: (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
                                                                    ImageChunkEvent
                                                                        loadingProgress) {
                                                                  if (loadingProgress ==
                                                                      null)
                                                                    return child;
                                                                  return Center(
                                                                    child:
                                                                        CupertinoActivityIndicator(
                                                                      radius: loadingProgress.expectedTotalBytes !=
                                                                              null
                                                                          ? loadingProgress.cumulativeBytesLoaded /
                                                                              loadingProgress.expectedTotalBytes
                                                                          : null,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              // decoration: BoxDecoration(
                                                              //     image: DecorationImage(
                                                              //         image: NetworkImage(
                                                              //             "${Api.imageUrl}${image.map((e) => e.toString()).join()}"),
                                                              //         fit: BoxFit.cover)),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 130.0,
                                                                  child: Text(
                                                                      prod.name,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.grey)),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Text(
                                                                  '#${int.parse(cart.getCartItem.data.items.where((e) => e.id == cart.getCartItem.data.items[index].id).map((e) => e.quantity).toList().join()) * double.parse(cart.getCartItem.data.items.where((e) => e.id == cart.getCartItem.data.items[index].id).map((e) => e.product.prices.where((e) => e.unitId == cart.getCartItem.data.items[index].mUnitId).where((e) => e.id == cart.getCartItem.data.items[index].priceId).map((e) => e.priceRegular).join()).join())}/${prod.prices.where((e) => e.unit.id == cart.getCartItem.data.items[index].unit.id).map((e) => e.unit.abbreviation).join()}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12.0),
                                                                ),
                                                                SizedBox(
                                                                  height: 25.0,
                                                                ),
                                                                Row(
                                                                  // crossAxisAlignment: CrossAxisAlignment.,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          38.0,
                                                                      decoration: BoxDecoration(
                                                                          border:
                                                                              Border.all(color: kPrimaryColor.withOpacity(.3)),
                                                                          borderRadius: BorderRadius.circular(10.0)),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    Future.delayed(Duration(seconds: 5), () {
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                    return ProgressDialog(
                                                                                      message: "Please Wait..",
                                                                                    );
                                                                                  }).then((_) {
                                                                                // async{
                                                                                //  bool suc = await
                                                                                Provider.of<CartProvider>(context, listen: false).updateCart(cart.getCartItem.data.items[index].id, cart.getCartItem.data.items[index].quantity - 1, cart.getCartItem.data.items[index].productId);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                // padding: EdgeInsets.only(top:5.0),
                                                                                width: 40.0,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                                                                                  color: kPrimaryColor.withOpacity(.3),
                                                                                  // border: Border.all(color: kPrimaryColor.withOpacity(.3))
                                                                                ),
                                                                                child: Icon(Icons.remove, color: kPrimaryColor)),
                                                                          ),
                                                                          Container(
                                                                              width: 40.0,
                                                                              child: Text(
                                                                                "${cart.getCartItem?.data?.items[index].quantity}",
                                                                                // "${savedCartItem.cart.getCartItem[index].quantity} ${Provider.of<CartProvider>(context, listen:false).getQuantity}",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                                                              )),
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    Future.delayed(Duration(seconds: 5), () {
                                                                                      Navigator.pop(context);
                                                                                    });
                                                                                    return ProgressDialog(
                                                                                      message: "Please Wait..",
                                                                                    );
                                                                                  }).then((_) {
                                                                                // async{
                                                                                //  bool suc = await
                                                                                Provider.of<CartProvider>(context, listen: false).updateCart(cart.getCartItem.data.items[index].id, cart.getCartItem?.data?.items[index].quantity + 1, cart.getCartItem.data.items[index].productId);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                width: 40.0,
                                                                                height: 50,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                                                                                  color: kPrimaryColor.withOpacity(.3),
                                                                                  // border: Border.all(color: kPrimaryColor)
                                                                                ),
                                                                                child: Icon(Icons.add, color: kPrimaryColor)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        20.0),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    border: Border
                                                                        .all(
                                                                            // width: 3.0,
                                                                            color:
                                                                                kPrimaryColor),
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            30.0))),
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        Future.delayed(
                                                                            Duration(seconds: 5),
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        });
                                                                        return ProgressDialog(
                                                                          message:
                                                                              "Please Wait..",
                                                                        );
                                                                      }).then((_) {
                                                                    // async{
                                                                    //  bool suc = await
                                                                    Provider.of<CartProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .deleteCart(cart
                                                                            .getCartItem
                                                                            .data
                                                                            .items[index]
                                                                            .id);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                    FontAwesomeIcons
                                                                        .trash,
                                                                    color: Colors
                                                                        .white)))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            })),
                                // ),
                              ],
                            ),
            )));
  }
}

class OrderButton extends StatefulWidget {
  final int cartIdLength;
  // final int productId;
  // final int unitId;
  final int totalAmount;
  OrderButton({this.totalAmount, this.cartIdLength});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  // final CartModel carts = CartModel();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(10.0)),
        // ignore: deprecated_member_use
        child: FlatButton(
            onPressed: () {
              if (this.widget.cartIdLength > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutPage(
                              totalAmount: widget.totalAmount,
                            )));
              } else {
                print('No Item in Cart');
              }
            },
            child: Text(
              "Check out",
              style: TextStyle(color: Colors.white),
            )));
  }
}
