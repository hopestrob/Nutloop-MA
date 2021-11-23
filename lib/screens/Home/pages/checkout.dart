import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/model/Wallet_model.dart';
// import 'package:nuthoop/model/user.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/widget/bottomModalLocation.dart';
import 'package:nuthoop/screens/Home/widget/checkOutAddCard.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:nuthoop/screens/Home/widget/topUpwallet.dart';
import 'package:nuthoop/screens/Users/addressbook.dart';
import 'package:paystack_manager/paystack_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import '../successfulOrder.dart';

class CheckOutPage extends StatefulWidget {
  final int totalAmount;
  CheckOutPage({this.totalAmount});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int addressIdFromList;
  TextEditingController topUpWalletController = TextEditingController();
  bool loading = false;
  @override
  void didChangeDependencies() {
    // Provider.of<CartProvider>(context).getSavedCartItemsList();
    Provider.of<Authentication>(context, listen: false)
        .getAddressBookDetails(addressIdFromList);
    super.didChangeDependencies();
  }

  void onPay() {}
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressBookScreen(),
        ));
    // after the SecondScreen result comes back update the Text widget with it

    print('this is resulr $result');
    setState(() {
      addressIdFromList = result;
    });
  }

  bool loadingPayment = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Authentication>(context, listen: false)
          .getProfileDetail(context);
      Provider.of<Authentication>(context, listen: false).getWallet(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    Provider.of<Authentication>(context, listen: false)
        .getAddressBookDetails(addressIdFromList);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor4,
        key: _scaffoldKey,
        body: loading == true
            ? SafeArea(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 10.0),
                  width: 200.0,
                  height: 200,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48.0,
                              height: 48.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Container(
                                    width: 40.0,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: 6,
                    ),
                  ),
                ),
              )
            : SafeArea(child:
                Consumer<Authentication>(builder: (_, userDetails, child) {
                return Container(
                    child: ListView(children: <Widget>[
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 10.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  size: 30, color: greyColor2)),
                          SizedBox(width: 100.0),
                          Center(
                            child: Text('Checkout',
                                style: TextStyle(
                                    color: kBrandColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text('my Card'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 20.0),
                                  child: Text('My Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0)),
                                ),
                                cart.getCartItem.data.items.length < 4
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          // print(scakey.currentState);
                                          // scakey.currentState.onItemTapped(2);
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Text('View All',
                                              style: TextStyle(
                                                  color: kBrandColor,
                                                  fontSize: 16.0)),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: double.infinity,
                            padding: EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: new List.generate(
                                  cart.getCartItem.data?.items?.length ?? 0,
                                  (index) {
                                var image = json.decode(cart.getCartItem.data
                                    .items[index].product.images);
                                return Container(
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0)),
                                    child: Image.network(
                                        "${Api.imageUrl}${image.map((e) => e.toString()).join()}"));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Consumer<Authentication>(
                    builder: (_, getAddressBookDetailcon, child) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            getAddressBookDetailcon.getAddressBookDetail.id !=
                                    null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Delivery Address',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0)),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _awaitReturnValueFromSecondScreen(
                                                  context);
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin:
                                                        EdgeInsets.all(15.0),
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green
                                                            .withOpacity(.1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30.0)),
                                                        border: Border.all(
                                                            color: kBrandColor,
                                                            width: 2)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 3,
                                                                bottom: 3),
                                                        child: Text(
                                                          'Change Address',
                                                          style: TextStyle(
                                                              color:
                                                                  kBrandColor),
                                                        )))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      getAddressBookDetailcon
                                                  .getAddressBookDetail.id ==
                                              null
                                          ? SizedBox()
                                          : Consumer<Authentication>(
                                              builder: (_, authUser, child) => Text(
                                                  '${authUser.getAddressBookDetail.houseNo.toString()}, ${authUser.getAddressBookDetail.street.toString()}, ${authUser.getAddressBookDetail.city.toString()}')),
                                      SizedBox(height: 20.0),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Delivery Address *',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0)),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _awaitReturnValueFromSecondScreen(
                                              context);
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(15.0),
                                                padding: EdgeInsets.all(2.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.green
                                                        .withOpacity(.1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30.0)),
                                                    border: Border.all(
                                                        color: kBrandColor,
                                                        width: 2)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0,
                                                            top: 3,
                                                            bottom: 3),
                                                    child: Text(
                                                      'Add Delivery Address',
                                                      style: TextStyle(
                                                          color: kBrandColor),
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Consumer<CartProvider>(
                      builder: (_, deliveryPro, child) => Card(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Delivery Options *',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deliveryPro.standardDelivery(
                                          this.widget.totalAmount);
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          // decoration: BoxDecoration(
                                          //     shape: BoxShape.circle, color: kBrandColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child:
                                                deliveryPro.getStandardDelivery
                                                    ? Icon(
                                                        Icons.check,
                                                        size: 30.0,
                                                        color: kBrandColor,
                                                      )
                                                    : Icon(
                                                        Icons
                                                            .radio_button_off_outlined,
                                                        size: 30.0,
                                                        color: kBrandColor,
                                                      ),
                                          ),
                                        ),
                                        Container(
                                          width: 250,
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text(
                                                  'N500 ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Standard Delivery'),
                                              ],
                                            ),
                                            subtitle: Text(
                                                '30 Minutes Maximum Delivery Time'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  line(context),
                                  InkWell(
                                    onTap: () async {
                                      // print('this is address ${deliveryPro.getExpressPickUpAddress}');
                                      deliveryPro.pickUpSale();
                                      await showModalBottomSheet(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(
                                                          30.0))),
                                          builder: (ctx) {
                                            return BottomSheetModel();
                                          });
                                      // if(res == deliveryPro.getExpressPickUpAddress){
                                      //   print('this is from main Check out ${deliveryPro.getExpressPickUpAddress}');
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          // decoration: BoxDecoration(
                                          //     shape: BoxShape.circle, color: kBrandColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: deliveryPro.getPickUpSale
                                                ? Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  ),
                                          ),
                                        ),
                                        Container(
                                          width: 250,
                                          child: ListTile(
                                            title: Text(
                                                'Pick Up from Order Sales Partner'),
                                            subtitle: Text(
                                                'Choose the closest Location to You for Pickup'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  deliveryPro.getPickUpSale == false
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Pick Up Details',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0)),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  deliveryPro.getExpressPickUpAddress ==
                                                          null
                                                      ? Text(
                                                          ' ${deliveryPro.expressPickUpPlaceArea.toString()}')
                                                      : Text(deliveryPro
                                                          .getExpressPickUpAddress
                                                          .toString()),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 30.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Contacts',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0)),
                                                    Container(
                                                        width: 180,
                                                        margin: EdgeInsets.only(
                                                            bottom: 10.0,
                                                            top: 5.0),
                                                        child: Text(
                                                            '${deliveryPro.expressPickUpPlace.toString()} ${deliveryPro.expressPickUpPlaceAgent.toString()} ')),
                                                    Text('2348164293279'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          )),
                  Consumer<CartProvider>(
                      builder: (_, deliveryPro, child) => Card(
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Payments *',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      deliveryPro.setPayWithWallet();
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          // decoration: BoxDecoration(
                                          //     shape: BoxShape.circle, color: kBrandColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: deliveryPro.getPayWithWallet
                                                ? Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            // margin: EdgeInsets.all(5.0),
                                            width: 250,
                                            child: ListTile(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Pay with wallet ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'For contactless Delivery we recommend Go Cashless and stay with wallet payment',
                                                    // overflow: TextOverflow.ellipsis,
                                                    // softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      // color: Colors.white
                                                      // 14.0
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  deliveryPro.getPayWithWallet == false
                                      ? SizedBox()
                                      : Container(
                                          color: kBrandColor.withOpacity(.2),
                                          padding: const EdgeInsets.all(16.0),
                                          margin: const EdgeInsets.all(16.0),
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  left: 10.0, right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .wallet,
                                                          color: kBrandColor),
                                                      SizedBox(width: 5.0),
                                                      Selector<Authentication,
                                                              WalletModel>(
                                                          selector: (_,
                                                                  userDetail) =>
                                                              userDetail
                                                                  .getSingleUserWallet,
                                                          builder: (_,
                                                              userDetails,
                                                              child) {
                                                            return Text(
                                                                '₦${userDetails.data?.totalBalance == null ? '0' : userDetails.data?.totalBalance.toString()}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        kBrandColor,
                                                                    fontSize:
                                                                        12.0));
                                                          }),
                                                    ],
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(
                                                                              30.0))),
                                                          builder: (ctx) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          100.0),
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .center,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            30.0,
                                                                      ),
                                                                      Flexible(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              RichText(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            text:
                                                                                TextSpan(children: [
                                                                              TextSpan(
                                                                                text: 'Top-up wallet',
                                                                                style: TextStyle(
                                                                                  color: kBrandColor,
                                                                                  fontSize: 18,
                                                                                  // fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          )),
                                                                      SizedBox(
                                                                        height:
                                                                            30.0,
                                                                      ),
                                                                      Flexible(
                                                                        flex: 1,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                                                                              child: Text('Enter Amount'),
                                                                            ),
                                                                            Container(
                                                                                width: double.infinity,
                                                                                height: 50,
                                                                                margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
                                                                                padding: EdgeInsets.all(5.0),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), border: Border.all(color: kBrandColor, style: BorderStyle.solid, width: 1.80)),
                                                                                child: TextField(
                                                                                  controller: topUpWalletController,
                                                                                  decoration: InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, errorBorder: InputBorder.none, disabledBorder: InputBorder.none, contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15), hintText: '₦0.00'),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container(
                                                                            //300
                                                                            margin:
                                                                                EdgeInsets.only(top: 20),
                                                                            width:
                                                                                83.33 * SizeConfig.widthMultiplier,
                                                                            decoration:
                                                                                BoxDecoration(color: Color(0xff80C46D), borderRadius: BorderRadius.circular(10.0)),
                                                                            child: loading == true
                                                                                ? CupertinoActivityIndicator()
                                                                                : TextButton(
                                                                                    onPressed: () {
                                                                                      _processWalletPayment(topUpWalletController.text.trim().toString(), "${userDetails.getSingleUserDetail.data.user.email.toString()}", "${userDetails.getSingleUserDetail.data.user.name.toString()}", "${userDetails.getSingleUserDetail.data.user.id.toString()}", "${userDetails.getSingleUserDetail.data.user.psCusId.toString()}", "${Provider.of<CartProvider>(context, listen: false).getCreateOrderDetail.id}", "TopUp");
                                                                                    },
                                                                                    child: Text(
                                                                                      'Pay',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    ),
                                                                                  ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 120,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green
                                                                    .withOpacity(
                                                                        .1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(Radius
                                                                            .circular(
                                                                                30.0)),
                                                                border: Border.all(
                                                                    color:
                                                                        kBrandColor,
                                                                    width: 2)),
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0,
                                                                        right:
                                                                            10.0,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                  'Top Up Wallet',
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBrandColor),
                                                                )))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                  line(context),
                                  InkWell(
                                    onTap: () async {
                                      // print('this is address ${deliveryPro.getExpressPickUpAddress}');
                                      deliveryPro.setPayWithCard();
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 15.0),
                                          // decoration: BoxDecoration(
                                          //     shape: BoxShape.circle, color: kBrandColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: deliveryPro.getPayWithCard
                                                ? Icon(
                                                    Icons.check,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .radio_button_off_outlined,
                                                    size: 30.0,
                                                    color: kBrandColor,
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: 250,
                                            child: ListTile(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('Pay with card',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      'Your Security is our Priority. Enjoy Quick & easy Payment -Pay Security via Your Mastercard, Visa and Verve Cards of all Banks',
                                                      // overflow: TextOverflow.ellipsis,
                                                      // softWrap: true,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        // color: Colors.white
                                                        // 14.0
                                                      ))),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          )),
                  Card(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Center(child: Image.asset('asset/card.png'))
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 30.0, bottom: 8.0),
                          child: Text('Sub-total',
                              style: TextStyle(fontSize: 18.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0, bottom: 8.0),
                          // child: Text('${this.widget.amount}'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, bottom: 8.0),
                          child: Text('Total to Pay',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 30.0, bottom: 8.0),
                          child: Text(
                              Provider.of<CartProvider>(context)
                                          .getStandardDelivery ==
                                      false
                                  ? '${this.widget.totalAmount}'
                                  : '${this.widget.totalAmount + 500}',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  Consumer<CartProvider>(
                      builder: (_, submitOrder, child) => Container(
                            height: 70.0,
                            margin: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Provider.of<Authentication>(context,
                                                    listen: false)
                                                .getAddressBookDetail
                                                .id ==
                                            null ||
                                        submitOrder.getPickUpSale == false &&
                                            submitOrder.getStandardDelivery ==
                                                false ||
                                        submitOrder.getPayWithCard == false &&
                                            submitOrder.getPayWithWallet ==
                                                false
                                    ? kPrimaryColor.withOpacity(.2)
                                    : kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextButton(
                                onPressed: () async {
                                  if (Provider.of<Authentication>(context,
                                              listen: false)
                                          .getAddressBookDetail
                                          .id ==
                                      null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        displayMessage(
                                            'Address Must be Added'));
                                  } else if (submitOrder.getPickUpSale ==
                                          false &&
                                      submitOrder.getStandardDelivery ==
                                          false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        displayMessage(
                                            'Kindly Select Delivery Method'));
                                  } else if (submitOrder.getPayWithCard ==
                                          false &&
                                      submitOrder.getPayWithWallet == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        displayMessage(
                                            'Kindly Select Payment Method'));
                                  } else {
                                    if (submitOrder.getPayWithWallet == true) {
                                      // print('payment with wallet');
                                      setState(() {
                                        loadingPayment = true;
                                      });
                                      if (int.parse(Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getSingleUserWallet
                                                  ?.data
                                                  ?.totalBalance
                                                  .toString() ??
                                              0.toString()) >=
                                          int.parse(Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .getStandardDelivery ==
                                                  false
                                              ? '${this.widget.totalAmount}'
                                              : '${this.widget.totalAmount + 500}')) {
                                        if (!await context
                                            .read<CartProvider>()
                                            .orders(
                                                context,
                                                Provider.of<Authentication>(
                                                        context,
                                                        listen: false)
                                                    .getAddressBookDetail
                                                    .id
                                                    .toString(),
                                                'Wallet',
                                                Provider.of<Authentication>(
                                                        context,
                                                        listen: false)
                                                    .getAddressBookDetail
                                                    .deliveryInstructions
                                                    .toString(),
                                                Provider.of<CartProvider>(
                                                                context,
                                                                listen: false)
                                                            .getPickUpSale ==
                                                        true
                                                    ? "PickUp"
                                                    : "Standard Mode")) {
                                          switch (context
                                              .read<CartProvider>()
                                              .orderState) {
                                            case OrderState.error:
                                              // print('Error Procrossing Your order');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(displayMessage(
                                                      'Error Processsing Your Order'));
                                          }
                                        } else {
                                          setState(() {
                                            loadingPayment = false;
                                          });
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .getSavedCartItemsList(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SuccessfulCheckOutPage(
                                                          amount: double.parse(
                                                        "${Provider.of<CartProvider>(context).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                                                      ))));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(displayMessage(
                                                'Insuffient Money in Wallet'));
                                      }
                                    } else {
                                      _processPayment(
                                          "${Provider.of<CartProvider>(context, listen: false).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                                          "${userDetails.getSingleUserDetail.data.user.email.toString()}",
                                          "${userDetails.getSingleUserDetail.data.user.name.toString()}",
                                          "${userDetails.getSingleUserDetail.data.user.id.toString()}",
                                          "${userDetails.getSingleUserDetail.data.user.psCusId.toString()}",
                                          "${Provider.of<CartProvider>(context, listen: false).getCreateOrderDetail.id}",
                                          "Check Out");
                                    }
                                  }
                                },
                                child: loadingPayment == true
                                    ? CupertinoActivityIndicator()
                                    : Text(
                                        'Place Order',
                                        style: TextStyle(color: Colors.white),
                                      )),
                          )),
                ]));
              })));
  }

  void _processPayment(
      String amount, email, name, userId, pcusId, orderId, module) {
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_790d4257bf8a02abe1d35aab0accb11041ffbcfa")
        // ..setSecretKey("sk_test_e593d547f41472da7e2756d29f18c1d7bc488acd")
// Your company Image
        // ..setCompanyAssetImage(Image(
        //   image: NetworkImage(
        //       "https://res.cloudinary.com/acctgen1/image/upload/v1612393902/TECH2-01_vw1fvg.png"),
        // ))
        ..setAmount(int.parse(
            '${amount}00')) // you need to add two zeros at the end e.g 100000 = N1,000.00
// you can set your own unique transaction reference, here am using timestamp
        ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
        ..setCurrency(
            "NGN") // Set currency, the platform only has three currencies, when registering the
//list of countries listed is the currency that is available for you to use
        ..setEmail("$email") // user email address and information
        ..setFirstName("$name")
        // ..setLastName("Test2")
        ..onSuccesful(module == "Check Out"
            ? _onPaymentSuccessful
            : _onPaymentSuccessfulAddWallet)
        ..setMetadata(
          {
            "custom_fields": [
              {
                "order_id": "$orderId", // set this your company name
                "module": "$module",
                "user": "$userId",
                "ps_cus_id": "$pcusId"
              }
            ]
          },
        )
        ..onPending(_onPaymentPending)
        ..onFailed(_onPaymentFailed)
        ..onCancel(_onCancel)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  void _onPaymentSuccessful(Transaction transaction) async {
    setState(() {
      loading = true;
    });
    if (!await context.read<CartProvider>().orders(
        context,
        Provider.of<Authentication>(context, listen: false)
            .getAddressBookDetail
            .id
            .toString(),
        'Online',
        Provider.of<Authentication>(context, listen: false)
            .getAddressBookDetail
            .deliveryInstructions
            .toString(),
        Provider.of<CartProvider>(context, listen: false).getPickUpSale == true
            ? "PickUp"
            : "Standard Mode")) {
      switch (context.read<CartProvider>().orderState) {
        case OrderState.error:
          // print('Error Procrossing Your order');
          ScaffoldMessenger.of(context)
              .showSnackBar(displayMessage('Error Processsing Your Order'));
      }
    } else {
      Provider.of<CartProvider>(context, listen: false)
          .getSavedCartItemsList(context);
      Provider.of<CartProvider>(context, listen: false)
          .compeletTransaction(transaction.refrenceNumber);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SuccessfulCheckOutPage(
                amount: double.parse(
                  "${Provider.of<CartProvider>(context).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                ),
                transactionRefNum: transaction.refrenceNumber,
              )));
      // (Route<dynamic> route) => false);
    }
  }

  void _onPaymentPending(Transaction transaction) async {
    print('Transaction Pending');
    print("Transaction Ref ${transaction.refrenceNumber}");
    Navigator.of(context).pop();
  }

  void _onPaymentFailed(Transaction transaction) {
    print('Transaction Failed');
    print("Transaction message ==> ${transaction.message}");
    Navigator.pop(context);
  }

  void _onCancel(Transaction transaction) {
    print('Transaction Cancelled');
    Navigator.of(context).pop();
  }

  void _processWalletPayment(
      String amount, email, name, userId, pcusId, orderId, module) {
    setState(() {
      loading = true;
    });
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_790d4257bf8a02abe1d35aab0accb11041ffbcfa")
        // ..setSecretKey("sk_test_e593d547f41472da7e2756d29f18c1d7bc488acd")
// Your company Image
        // ..setCompanyAssetImage(Image(
        //   image: NetworkImage(
        //       "https://res.cloudinary.com/acctgen1/image/upload/v1612393902/TECH2-01_vw1fvg.png"),
        // ))
        ..setAmount(int.parse(
            '${amount}00')) // you need to add two zeros at the end e.g 100000 = N1,000.00
// you can set your own unique transaction reference, here am using timestamp
        ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
        ..setCurrency(
            "NGN") // Set currency, the platform only has three currencies, when registering the
//list of countries listed is the currency that is available for you to use
        ..setEmail("$email") // user email address and information
        ..setFirstName("$name")
        // ..setLastName("Test2")
        ..onSuccesful(_onPaymentSuccessfulAddWallet)
        ..setMetadata(
          {
            "order_id": "",
            "module": "TopUp",
            "user": "$userId",
            "ps_cus_id": " "
          },
        )
        ..onPending(_onPaymentWalletPending)
        ..onFailed(_onPaymentWalletFailed)
        ..onCancel(_onWalletCancel)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  void _onPaymentSuccessfulAddWallet(Transaction transaction) async {
    Provider.of<CartProvider>(context, listen: false)
        .compeletTransaction(transaction.refrenceNumber)
        .then((_) => {
              setState(() {
                loading = false;
              })
            })
        .then((_) => {
              topUpSuccessBottomSheet(context, transaction.refrenceNumber,
                  topUpWalletController.text.trim()),
              Provider.of<Authentication>(context, listen: false)
                  .getWallet(context)
            });
  }

  void _onPaymentWalletPending(Transaction transaction) async {
    print('Transaction Pending');
    print("Transaction Ref ${transaction.refrenceNumber}");
    Navigator.of(context).pop();
  }

  void _onPaymentWalletFailed(Transaction transaction) {
    print('Transaction Failed');
    print("Transaction message ==> ${transaction.message}");
    setState(() {
      loading = false;
      topUpWalletController.clear();
    });
    Navigator.pop(context);
  }

  void _onWalletCancel(Transaction transaction) {
    print('Transaction Cancelled');
    setState(() {
      loading = false;
      topUpWalletController.clear();
    });
    Navigator.of(context).pop();
  }
}
