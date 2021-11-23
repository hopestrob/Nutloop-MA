// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuthoop/model/Wallet_model.dart';
// import 'package:nuthoop/helper/api.dart';
// import 'package:nuthoop/model/addressBook.dart';
// import 'package:nuthoop/model/transactionModel.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
// import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/widget/topUpwallet.dart';
import 'package:paystack_manager/paystack_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/config_size.dart';
import 'addCard.dart';

// ignore: must_be_immutable
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key key}) : super(key: key);
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController topUpWalletController = TextEditingController();
  TabController _tabController;
  bool taps = false;
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<Authentication>(context, listen: false)
          .getWalletTransaction();
      Provider.of<Authentication>(context, listen: false).getWallet(context);
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // Provider.of<Authentication>(context, listen: false).getWalletTransaction();
    Provider.of<Authentication>(context, listen: false).getWallet(context);
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final getWalletData =
    //     Provider.of<Authentication>(context, listen: false).getSingleUserWallet;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Consumer<Authentication>(
              builder: (context, getWalletDatas, child) {
            // var getWalletData = getWalletDatas.getWalletData;
            // print('thius is wallet page ${getWalletData.data?.totalBalance}');
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        margin: EdgeInsets.only(top: 20.0, left: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios,
                                size: 30, color: greyColor2),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                            ),
                            Text(
                              'My Wallet',
                              style: TextStyle(
                                  color: kBrandColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  )),
                  SizedBox(height: 0.56 * SizeConfig.heightMultiplier),

                  Container(
                      margin:
                          EdgeInsets.only(top: 20.0, left: 20.0, bottom: 5.0),
                      child: Text('Your current wallet balance is :',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Selector<Authentication, WalletModel>(
                              selector: (_, userDetail) =>
                                  userDetail.getSingleUserWallet,
                              builder: (_, userDetails, child) {
                                return Text(
                                    '₦${userDetails.data?.totalBalance == null ? '0' : userDetails.data?.totalBalance.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kBrandColor,
                                        fontSize: 12.0));
                              }),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30.0))),
                                  builder: (ctx) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 100.0),
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 30.0,
                                              ),
                                              Flexible(
                                                  flex: 1,
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
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
                                                height: 30.0,
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30,
                                                          vertical: 1),
                                                      child:
                                                          Text('Enter Amount'),
                                                    ),
                                                    Container(
                                                        width: double.infinity,
                                                        height: 50,
                                                        margin: EdgeInsets.only(
                                                            top: 5.0,
                                                            left: 30.0,
                                                            right: 30.0),
                                                        padding:
                                                            EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                            border: Border.all(
                                                                color:
                                                                    kBrandColor,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                width: 1.80)),
                                                        child: TextField(
                                                          controller:
                                                              topUpWalletController,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 15,
                                                                      bottom:
                                                                          11,
                                                                      top: 11,
                                                                      right:
                                                                          15),
                                                              hintText:
                                                                  '₦0.00'),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    //300
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    width: 83.33 *
                                                        SizeConfig
                                                            .widthMultiplier,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff80C46D),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: Consumer<
                                                        Authentication>(
                                                      builder: (_, userDetails,
                                                              child) =>
                                                          TextButton(
                                                        onPressed: () {
                                                          _processWalletPayment(
                                                              topUpWalletController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                              "${userDetails.getSingleUserDetail.data.user.email.toString()}",
                                                              "${userDetails.getSingleUserDetail.data.user.name.toString()}",
                                                              "${userDetails.getSingleUserDetail.data.user.id.toString()}");
                                                        },
                                                        child: Text(
                                                          'Pay',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
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
                                          'Top Up Wallet',
                                          style: TextStyle(color: kBrandColor),
                                        )))
                              ],
                            ),
                          ),
                        ],
                      )),
                  // Text(),
                  Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 20.0, bottom: 2.0),
                      child: Text(
                        'My wallet Transactions',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 5.0),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TabBar(
                            controller: _tabController,
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
                        Consumer<Authentication>(
                            builder: (context, transactions, child) {
                          var transaction = transactions.getWalletData;
                          return transactions.walletLoaded == false
                              ? Container(
                                  width: 200.0,
                                  height: 200,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    enabled: true,
                                    child: ListView.builder(
                                      itemBuilder: (_, __) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 48.0,
                                              height: 48.0,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 8.0,
                                                    color: Colors.white,
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.0),
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
                                )
                              : Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      transaction.length == 0
                                          ? Center(
                                              child: Text('No Trasaction Yet'))
                                          : ListView.builder(
                                              reverse: transaction.length > 1
                                                  ? true
                                                  : false,
                                              itemCount:
                                                  transaction.length ?? 0,
                                              itemBuilder: (_, index) {
                                                var orderedItem =
                                                    transaction[index];
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  margin: EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      bottom: 5.0),
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
                                                                '${DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt))}',
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
                                                                  "${orderedItem.orderId == null ? '' : orderedItem.orderId}",
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
                                                                  "Transaction:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                              Text(
                                                                  "₦${orderedItem.cardAmount}",
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
                                                                  "₦${orderedItem.closingBalance}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBrandColor))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                      // }),
                                      // second tab bar view widget

                                      // Selector<Authentication,
                                      //         List<TransactionModel>>(
                                      //     selector: (_, userDetail) =>
                                      //         userDetail.getWalletData,
                                      //     builder: (_, userDetails, child) {
                                      //       return
                                      transaction.length == 0
                                          ? Center(
                                              child: Text('No Trasaction Yet'))
                                          : ListView.builder(
                                              reverse: transaction.length > 1
                                                  ? true
                                                  : false,
                                              itemCount:
                                                  transaction.length ?? 0,
                                              itemBuilder: (_, index) {
                                                var orderedItem =
                                                    transaction[index];
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  margin: EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      bottom: 5.0),
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
                                                                '${DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt))}',
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
                                                                  "${orderedItem.orderId == null ? '' : orderedItem.orderId}",
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
                                                              Text("Deposit:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                              Text(
                                                                  "₦${orderedItem.creditAmount}",
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
                                                                  "₦${orderedItem.closingBalance}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBrandColor))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                                // });
                                              }),
                                      // Selector<Authentication,
                                      //         List<TransactionModel>>(
                                      //     selector: (_, userDetail) =>
                                      //         userDetail.getWalletData,
                                      //     builder: (_, userDetails, child) {
                                      //       return
                                      transaction.length == 0
                                          ? Center(
                                              child: Text('No Trasaction Yet'))
                                          : ListView.builder(
                                              reverse: transaction.length > 1
                                                  ? true
                                                  : false,
                                              itemCount:
                                                  transaction.length ?? 0,
                                              itemBuilder: (_, index) {
                                                var orderedItem =
                                                    transaction[index];
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  margin: EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      bottom: 5.0),
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
                                                                '${DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt))}',
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
                                                                  "${orderedItem.orderId == null ? '' : orderedItem.orderId}",
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
                                                                  "₦${orderedItem.debitAmount}",
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
                                                                  "₦${orderedItem.closingBalance}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBrandColor))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                      // })
                                    ],
                                  ),
                                );
                        }),
                        //   }
                      ],
                    ),
                  )

                  // tab bar view here
                ]);
          })),
    );
  }

  void _processWalletPayment(String amount, email, name, userId) {
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
    print(
        'this is user Id after Transaction is successful ${Provider.of<Authentication>(context, listen: false).getSingleUserDetail.data.user.id.toString()}');
    setState(() {
      loading = true;
    });
    print("Transaction Ref ${transaction.refrenceNumber}");
    Provider.of<CartProvider>(context, listen: false)
        .compeletTransaction(transaction.refrenceNumber)
        .then((_) => {
              setState(() {
                loading = false;
              })
            })
        .then((_) => {
              topUpSuccessBottomSheet(context, transaction.refrenceNumber,
                  topUpWalletController.text.trim())
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
    Navigator.pop(context);
  }

  void _onWalletCancel(Transaction transaction) {
    print('Transaction Cancelled');
    Navigator.of(context).pop();
  }
}
