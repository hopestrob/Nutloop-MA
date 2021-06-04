import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:provider/provider.dart';

import '../../helper/config_size.dart';
import 'addCard.dart';

// ignore: must_be_immutable
class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool taps = false;

  @override
  Widget build(BuildContext context) {
    Provider.of<Authentication>(context, listen: false).getWalletTransaction();
    final walletDetail =
        Provider.of<Authentication>(context, listen: false).getSingleUserWallet;
    //  Provider.of<Authentication>(context, listen: false).getAddressBookDetail();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            Container(
                child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Consumer<Authentication>(
                          builder: (_, authuser, child) => Homepage(
                              authName: "${authuser.getAuthUser}",
                              selectedPage: 3)),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: Container(
                  padding: EdgeInsets.only(top: 8.0),
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back_ios, size: 30, color: greyColor2),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                      ),
                      Text(
                        'My Wallet',
                        style: TextStyle(
                            color: kBrandColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            )),
            SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: ListView(
                    // ?crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              top: 20.0, left: 20.0, bottom: 5.0),
                          child: Text('Your current wallet balance is :',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Text(
                              'N${walletDetail.data?.amount == null ? '0' : walletDetail.data?.amount.toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      // Text(),
                      Container(
                          margin: EdgeInsets.only(
                              top: 30.0, left: 20.0, bottom: 10.0),
                          child: Text(
                            'My wallet Transactions',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(height: 20.0),
                      DefaultTabController(
                          length: 3, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TabBar(
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [Colors.grey, Colors.grey]),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.redAccent),
                                    tabs: [
                                      Tab(text: 'All'),
                                      Tab(text: 'Deposit'),
                                      Tab(text: 'Withdrawal'),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 550, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Consumer<Authentication>(
                                          builder: (_, cart, child) => Column(
                                                children: List.generate(
                                                    cart.getWalletData
                                                            ?.length ??
                                                        0, (index) {
                                                  var orderedItem =
                                                      cart.getWalletData[index];
                                                  return Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    margin:
                                                        EdgeInsets.all(20.0),
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Order Date: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  "${DateFormat('yyyy-MM-dd').parse(orderedItem.data.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.data.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.data.createdAt).day}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBrandColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          line(context),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Order No.: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                    "${orderedItem.data.id}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBrandColor))
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "Withdrawal:",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                Text(
                                                                    "${orderedItem.data.amount}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBrandColor))
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Ending balance: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                    "${orderedItem.data.amount}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBrandColor))
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 20.0),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              )),
                                      Container(
                                        child: Center(
                                          child: Text('No Transaction',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text('No Transactions',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]))
                              ])),
                    ]),
              ),
            )
          ]),
        ));
  }
}
