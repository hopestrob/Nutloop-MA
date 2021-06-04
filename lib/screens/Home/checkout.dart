import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:paystack_manager/paystack_manager.dart';
import 'package:provider/provider.dart';

// import 'addDeliveryAddress.dart';
import 'checkOutAddCard.dart';
import 'successfulOrder.dart';
import 'widget/bottomModalLocation.dart';
import '../Users/addressbook.dart';

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
  @override
  void didChangeDependencies() {
    // Provider.of<CartProvider>(context).getSavedCartItemsList();
    Provider.of<Authentication>(context, listen: false)
        .getAddressBookDetails(addressIdFromList);
    super.didChangeDependencies();
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressBookScreen(),
        ));
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      addressIdFromList = result;
    });
  }

//  @override
//   void initState() {
//      WidgetsBinding.instance.addPostFrameCallback((_){
//        Provider.of<CartProvider>(context, listen: false).compeletTransaction();
//     // Provider.of<CartProvider>(context, listen: false).getSavedCartItemsList();
//   });
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    Provider.of<Authentication>(context, listen: false)
        .getAddressBookDetails(addressIdFromList);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor4,
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                child: ListView(children: <Widget>[
          Card(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
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
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 20.0),
                          child: Text('My Cart',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text('View All',
                              style: TextStyle(
                                  color: kBrandColor, fontSize: 16.0)),
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
                          cart.getCartItem.data?.items?.length ?? 0, (index) {
                        var image = json.decode(
                            cart.getCartItem.data.items[index].product.images);
                        return Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0)),
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
                    getAddressBookDetailcon.getAddressBookDetail.id != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            margin: EdgeInsets.all(15.0),
                                            padding: EdgeInsets.all(2.0),
                                            decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(.1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0)),
                                                border: Border.all(
                                                    color: kBrandColor,
                                                    width: 2)),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 3,
                                                    bottom: 3),
                                                child: Text(
                                                  'Change Address',
                                                  style: TextStyle(
                                                      color: kBrandColor),
                                                )))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              getAddressBookDetailcon.getAddressBookDetail.id ==
                                      null
                                  ? SizedBox()
                                  : Consumer<Authentication>(
                                      builder: (_, authUser, child) => Text(
                                          '${authUser.getAddressBookDetail.houseNo.toString()}, ${authUser.getAddressBookDetail.street.toString()}, ${authUser.getAddressBookDetail.city.toString()}')),
                              SizedBox(height: 20.0),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  _awaitReturnValueFromSecondScreen(context);
                                },
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(15.0),
                                        padding: EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(.1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
                                            border: Border.all(
                                                color: kBrandColor, width: 2)),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 3,
                                                bottom: 3),
                                            child: Text(
                                              'Add Delivery Address',
                                              style:
                                                  TextStyle(color: kBrandColor),
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
                              deliveryPro
                                  .standardDelivery(this.widget.totalAmount);
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  // decoration: BoxDecoration(
                                  //     shape: BoxShape.circle, color: kBrandColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: deliveryPro.getStandardDelivery
                                        ? Icon(
                                            Icons.check,
                                            size: 30.0,
                                            color: kBrandColor,
                                          )
                                        : Icon(
                                            Icons.radio_button_off_outlined,
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
                                              fontWeight: FontWeight.bold),
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
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30.0))),
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
                                            Icons.radio_button_off_outlined,
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          deliveryPro.getExpressPickUpAddress ==
                                                  null
                                              ? Text('Sailas Charles')
                                              : Text(deliveryPro
                                                  .getExpressPickUpAddress
                                                  .toString()),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 30.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Contacts',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0)),
                                            Container(
                                                width: 180,
                                                margin: EdgeInsets.only(
                                                    bottom: 10.0, top: 5.0),
                                                child: Text(
                                                    '28 Peace Str. Ikeja, Lagos, Nigeria.')),
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
                                            Icons.radio_button_off_outlined,
                                            size: 30.0,
                                            color: kBrandColor,
                                          ),
                                  ),
                                ),
                                Container(
                                  // margin: EdgeInsets.all(5.0),
                                  width: 305,
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Pay with wallet ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'For contactless Delivery we recommend Go Cashless and stay with wallet payment',
                                        // textAlign: TextAlign.justify,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.wallet,
                                                  color: kBrandColor),
                                              SizedBox(width: 5.0),
                                              Consumer<Authentication>(
                                                  builder: (_, walletDetail,
                                                          child) =>
                                                      Text(
                                                          'N${walletDetail.getSingleUserWallet.data?.amount == null ? '0' : walletDetail.getSingleUserWallet.data?.amount.toString()}',
                                                          style: TextStyle(
                                                              color:
                                                                  kBrandColor))),
                                            ],
                                          ),
                                          SizedBox(width: 10.0),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                        // shape: RoundedRectangleBorder(
                                                        //     borderRadius:
                                                        //         BorderRadius
                                                        //             .circular(
                                                        //                 20.0)),
                                                        child: Container(
                                                      height: 120,
                                                      child: Column(
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                topUpWalletController,
                                                            decoration:
                                                                new InputDecoration(
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .greenAccent,
                                                                    width: 1.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .greenAccent,
                                                                    width: 1.0),
                                                              ),
                                                              hintText:
                                                                  'Top Up Amount',
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              _processPayment(
                                                                  topUpWalletController
                                                                      .text
                                                                      .trim()
                                                                      .toString(),
                                                                  "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.email.toString()}",
                                                                  "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.name.toString()}",
                                                                  "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.id.toString()}",
                                                                  "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.psCusId.toString()}",
                                                                  "${Provider.of<CartProvider>(context, listen: false).getCreateOrderDetail.id}",
                                                                  "Top Up Wallet");
                                                            },
                                                            child:
                                                                Text('TopUp'),
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                                  });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 120,
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
                                            Icons.radio_button_off_outlined,
                                            size: 30.0,
                                            color: kBrandColor,
                                          ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Pay with card',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Your Security is our Priority. Enjoy Quick & easy Payment -Pay Security via Your Mastercard, Visa and Verve Cards of all Banks'),
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
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 30.0, bottom: 8.0),
                  child: Text('Sub-total', style: TextStyle(fontSize: 18.0)),
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
                      Provider.of<CartProvider>(context, listen: false)
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
                                    submitOrder.getStandardDelivery == false ||
                                submitOrder.getPayWithCard == false &&
                                    submitOrder.getPayWithWallet == false
                            ? kPrimaryColor.withOpacity(.2)
                            : kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextButton(

                        // onPressed: ()=>_processPayment(),
                        onPressed: () async {
                          print(int.parse(Provider.of<Authentication>(context,
                                      listen: false)
                                  .getSingleUserWallet
                                  ?.data
                                  ?.amount ??
                              0.toString()));
                          if (Provider.of<Authentication>(context,
                                      listen: false)
                                  .getAddressBookDetail
                                  .id ==
                              null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Address Must be Added')));
                          } else if (submitOrder.getPickUpSale == false &&
                              submitOrder.getStandardDelivery == false) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Kindly Select Delivery Method')));
                          } else if (submitOrder.getPayWithCard == false &&
                              submitOrder.getPayWithWallet == false) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Kindly Select Payment Method')));
                          } else {
                            if (submitOrder.getPayWithWallet == true) {
                              print('payment with wallet');
                              if (int.parse(Provider.of<Authentication>(context,
                                              listen: false)
                                          .getSingleUserWallet
                                          ?.data
                                          ?.amount ??
                                      0.toString()) >=
                                  int.parse(Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .getStandardDelivery ==
                                          false
                                      ? '${this.widget.totalAmount}'
                                      : '${this.widget.totalAmount + 500}')) {
                                if (!await context.read<CartProvider>().orders(
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .getAddressBookDetail
                                        .id
                                        .toString(),
                                    'online',
                                    Provider.of<Authentication>(context,
                                            listen: false)
                                        .getAddressBookDetail
                                        .deliveryInstructions
                                        .toString(),
                                    Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .getPickUpSale ==
                                            true
                                        ? "PickUp"
                                        : "Standard Mode")) {
                                  switch (
                                      context.read<CartProvider>().orderState) {
                                    case OrderState.error:
                                      // print('Error Procrossing Your order');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error Processsing Your Order')));
                                  }
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SuccessfulCheckOutPage(
                                                amount: double.parse(
                                                  "${Provider.of<CartProvider>(context, listen: false).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                                                ),
                                              )),
                                      (Route<dynamic> route) => false);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Insuffient Money in Wallet')));
                              }
                            } else {
                              if (!await context.read<CartProvider>().orders(
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getAddressBookDetail
                                      .id
                                      .toString(),
                                  'online',
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getAddressBookDetail
                                      .deliveryInstructions
                                      .toString(),
                                  Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .getPickUpSale ==
                                          true
                                      ? "PickUp"
                                      : "Standard Mode")) {
                                switch (
                                    context.read<CartProvider>().orderState) {
                                  case OrderState.error:
                                    // print('Error Procrossing Your order');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error Processsing Your Order')));
                                }
                              } else {
                                // print('This is Order Id ${Provider.of<CartProvider>(context, listen: false).getCreateOrderDetail.id}');
                                _processPayment(
                                    "${Provider.of<CartProvider>(context, listen: false).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                                    "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.email.toString()}",
                                    "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.name.toString()}",
                                    "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.id.toString()}",
                                    "${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.psCusId.toString()}",
                                    "${Provider.of<CartProvider>(context, listen: false).getCreateOrderDetail.id}",
                                    "Check Out");
                                // Navigator.of(context).pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => SuccessfulCheckOutPage(
                                //             amount: double.parse(
                                //               "${Provider.of<CartProvider>(context, listen: false).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                                //             ),
                                //             )),
                                //     (Route<dynamic> route) => false);
                              }
                            }
                          }
                        },
                        child: Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white),
                        )),
                  )),
        ]))));
  }

  void _processPayment(
      String amount, email, name, userId, pcusId, orderId, module) {
    print('this is module $module');
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_ee1f56aabe9698b64e97385a2e362c860d168eb3")
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
    print('Transaction succesful');
    print(
        "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
    Provider.of<CartProvider>(context, listen: false)
        .compeletTransaction(transaction.refrenceNumber);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => SuccessfulCheckOutPage(
                  amount: double.parse(
                    "${Provider.of<CartProvider>(context, listen: false).getStandardDelivery == false ? this.widget.totalAmount : this.widget.totalAmount + 500}",
                  ),
                  transactionRefNum: transaction.refrenceNumber,
                )),
        (Route<dynamic> route) => false);
  }

  void _onPaymentSuccessfulAddWallet(Transaction transaction) async {
    Navigator.pop(context);
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
}
