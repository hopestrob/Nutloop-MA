import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Users/orders_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class SuccessfulCheckOutPage extends StatefulWidget {
  final double amount;
  final List<CartItem> products;
  final String transactionRefNum;

  SuccessfulCheckOutPage({this.amount, this.products, this.transactionRefNum});

  @override
  _SuccessfulCheckOutPageState createState() => _SuccessfulCheckOutPageState();
}

class _SuccessfulCheckOutPageState extends State<SuccessfulCheckOutPage> {
  // var currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: greyColor5,
          body: SafeArea(
              child: Container(
                  // margin: const EdgeInsets.all(10.0),
                  // padding: const EdgeInsets.all(8.0),
                  child: ListView(children: <Widget>[
            Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
                child: Row(
                  children: [
                    // InkWell(
                    //     onTap: () {
                    //       Navigator.of(context).pop();
                    //     },
                    //     child: Icon(Icons.arrow_back_ios,
                    //         size: 30, color: greyColor2)),
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
            Align(
              alignment: Alignment.center,
              child: Icon(Icons.check_circle_outline,
                  color: kBrandColor.withOpacity(0.7), size: 300),
            ),
            Align(
                alignment: Alignment.center,
                child: Text("Order Successful",
                    style: TextStyle(fontSize: 25.0, color: greyColor2))),
            Align(
                alignment: Alignment.center,
                child: Text(
                    'Transaction Number: ${this.widget.transactionRefNum}',
                    style: TextStyle(fontSize: 15.0, color: greyColor2))),
            Container(
              height: 70.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var authNames = prefs.getString('authName');
                    print(authNames);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                Homepage(authName: authNames)),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrdersDetailsScreen()));
                    },
                    child: Text("Proceed to Track Order",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: kPrimaryColor.withOpacity(0.8))))),
          ])))),
    );
  }
}
