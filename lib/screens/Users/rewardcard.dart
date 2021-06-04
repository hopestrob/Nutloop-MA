import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nutloop_ecommerce/model/ordered.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
// import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/checkOutAddCard.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../../helper/config_size.dart';

// ignore: must_be_immutable
class RewardCardpage extends StatefulWidget {
  @override
  _RewardCardpageState createState() => _RewardCardpageState();
}

class _RewardCardpageState extends State<RewardCardpage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final ordersDetails = Provider.of<List<OrderedModel>>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
            child: Column(children: [
          Card(
            child: Container(
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
                        'Reward card',
                        style: TextStyle(
                            color: kBrandColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            )),
          ),
          SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
          Expanded(
            child: Container(
              color: greyColor5,
              // margin: EdgeInsets.all(10.0),
              child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      padding: EdgeInsets.all(10.0),
                      color: kBrandColor.withOpacity(0.2),
                      height: 105,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'Upgrade to platinium Tier Reward Card',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(' by Earning'),
                              ],
                            ),
                          ),
                          Text('1,000  more Points'),
                          SizedBox(height: 8.0),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4),
                            title: Text('View Platinium Benefits',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: greyColor3)),
                            trailing: Text('How to Earn ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: greyColor3)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Card(
                      child: Container(
                        color: Colors.white,
                        height: 130,
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TOTAL MONEY SPENT',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0)),
                            Text('N23000',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      color: Colors.white,
                      height: 220,
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('POINT EARNED',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0)),
                          SizedBox(height: 5.0),
                          Text('1000',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0)),
                          SizedBox(height: 15.0),
                          line(context),
                          SizedBox(height: 5.0),
                          Text('Current Reward - Silver Tier'),
                          SizedBox(height: 5.0),
                          Text('Earned Since - 04 May 2021'),
                          SizedBox(height: 5.0),
                          Text('Learn About Eligible Points',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: greyColor3)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 200,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        //decoration for the outer wrapper
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(
                            30), //border radius exactly to ClipRRect
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                      child: ClipRRect(
                        //to clip overflown positioned containers.
                        borderRadius: BorderRadius.circular(30),
                        //if we set border radius on container, the overflown content get displayed at corner.
                        child: Container(
                            child: Stack(
                          children: <Widget>[
                            //Stack helps to overlap widgets
                            Positioned(
                                //positioned helps to position widget wherever we want.
                                top: -20,
                                left: -50, //position of the widget
                                child: Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: greyColor2.withOpacity(
                                            0.5) //background color with opacity
                                        ))),

                            Positioned(
                                left: -80,
                                top: -50,
                                child: Container(
                                    height: 180,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.withOpacity(0.5)))),

                            Positioned(
                              //main content container postition.
                              child: Container(
                                  height: 250,
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "Silver",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Positioned(
                              //main content container postition.
                              child: Container(
                                  height: 250,
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      "NUTLOOP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            Positioned(
                              //main content container postition.
                              child: Container(
                                  height: 250,
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Valid till -",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(
                                          Icons.calendar_view_month,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          "Dec., 2022",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RETAIN YOUR SILVER REWARD CARD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: greyColor3)),
                          SizedBox(height: 3.0),
                          Text('by Earning 500 more Points by 28th Nov. 2022'),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 400,
                            height: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.5,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    kBrandColor),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          ),
                          SizedBox(height: 3.0),
                          line(context),
                          SizedBox(height: 10.0),
                          Text('Upgrade to Platinium Tier Reward Card',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: greyColor3)),
                          SizedBox(height: 3.0),
                          Text('by Earning 1000 More points'),
                          SizedBox(height: 3.0),
                          Text('How to Upgrade',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: greyColor3)),
                        ],
                      ),
                    ),
                    // SizedBox(height: 5.0),
                    DefaultTabController(
                        length: 2, // length of tabs
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
                                    Tab(text: 'Activities'),
                                    Tab(text: 'Benefit'),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 550, //height of TabBarView
                                  // decoration: BoxDecoration(
                                  //     border: Border(
                                  //         top: BorderSide(
                                  //             color: Colors.grey, width: 0.5))),
                                  child: TabBarView(children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15.0),
                                          Text(
                                              'Base on your Activities in the last 12 Months',
                                              style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: greyColor3)),
                                          SizedBox(height: 15.0),
                                          Text('Points Earned',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: kBrandColor)),
                                          SizedBox(height: 15.0),
                                          Container(
                                            width: 250,
                                            margin: EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  kBrandColor.withOpacity(0.4),
                                            ),
                                            height: 90,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('1000',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30.0,
                                                        color: Colors.black)),
                                                SizedBox(height: 5.0),
                                                Text('Point earned',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15.0),
                                          Container(
                                            // width: 400,
                                            child: Column(children: <Widget>[
                                              Consumer<List<OrderedModel>>(
                                                  builder: (_, cart, child) {
                                                return (cart == null)
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : (cart.length == 0)
                                                        ? Center(
                                                            child: Text(
                                                                'No Order Details yet'),
                                                          )
                                                        : DataTable(
                                                            columns: [
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Order Date',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Order NO:',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Amount',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                              DataColumn(
                                                                  label: Text(
                                                                      'Points',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                            ],
                                                            // ordersDetails.getOrderedItem.
                                                            rows: List.generate(
                                                                cart.length ??
                                                                    0, (index) {
                                                              return DataRow(
                                                                  cells: [
                                                                    DataCell(
                                                                        Text(
                                                                      "${DateFormat('yyyy-MM-dd').parse(cart[index].createdAt).year}-${DateFormat('yyyy-MM-dd').parse(cart[index].createdAt).month}-${DateFormat('yyyy-MM-dd').parse(cart[index].createdAt).day}",
                                                                    )),
                                                                    DataCell(Text(
                                                                        '${cart[index].orderNo}')),
                                                                    DataCell(Text(
                                                                        'N${cart[index].total}')),
                                                                    DataCell(Text(
                                                                        '1000')),
                                                                  ]);
                                                            }),
                                                            //   DataRow(cells: [
                                                            //     DataCell(
                                                            //         Text('2 May 2021')),
                                                            //     DataCell(Text('6ueydt2')),
                                                            //     DataCell(Text('N3,000')),
                                                            //     DataCell(Text('1000')),
                                                            //   ]),
                                                            //   DataRow(cells: [
                                                            //     DataCell(
                                                            //         Text('2 May 2021')),
                                                            //     DataCell(Text('6ueydt2')),
                                                            //     DataCell(Text('N3,000')),
                                                            //     DataCell(Text('1000')),
                                                            //   ]),
                                                            //   DataRow(cells: [
                                                            //     DataCell(
                                                            //         Text('2 May 2021')),
                                                            //     DataCell(Text('6ueydt2')),
                                                            //     DataCell(Text('N3,000')),
                                                            //     DataCell(Text('1000')),
                                                            //   ]),
                                                            // ],
                                                          );
                                              }),
                                            ]),
                                          ),
                                          SizedBox(height: 15.0),
                                          Container(
                                            width: 350.0,
                                            child: TextButton(
                                                child: Text("View All".toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14)),
                                                style: ButtonStyle(
                                                    padding:
                                                        MaterialStateProperty.all<EdgeInsets>(
                                                            EdgeInsets.all(15)),
                                                    foregroundColor:
                                                        MaterialStateProperty.all<
                                                            Color>(kBrandColor),
                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(5.0),
                                                            side: BorderSide(color: kBrandColor)))),
                                                onPressed: () => null),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200.0,
                                          // width: 500.0,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 300,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  //decoration for the outer wrapper
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30), //border radius exactly to ClipRRect
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.5), //color of shadow
                                                      spreadRadius:
                                                          5, //spread radius
                                                      blurRadius:
                                                          7, // blur radius
                                                      offset: Offset(0,
                                                          2), // changes position of shadow
                                                      //first paramerter of offset is left-right
                                                      //second parameter is top to down
                                                    ),
                                                    //you can set more BoxShadow() here
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  //to clip overflown positioned containers.
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  //if we set border radius on container, the overflown content get displayed at corner.
                                                  child: Container(
                                                      child: Stack(
                                                    children: <Widget>[
                                                      //Stack helps to overlap widgets
                                                      Positioned(
                                                          //positioned helps to position widget wherever we want.
                                                          top: -20,
                                                          left:
                                                              -50, //position of the widget
                                                          child: Container(
                                                              height: 250,
                                                              width: 250,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: greyColor2
                                                                      .withOpacity(
                                                                          0.5) //background color with opacity
                                                                  ))),

                                                      Positioned(
                                                          left: -80,
                                                          top: -50,
                                                          child: Container(
                                                              height: 180,
                                                              width: 180,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5)))),

                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Text(
                                                                "Silver",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Text(
                                                                "NUTLOOP",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 30,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Valid till -",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_view_month,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                  Text(
                                                                    "Dec., 2022",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                width: 300,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  //decoration for the outer wrapper
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30), //border radius exactly to ClipRRect
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.5), //color of shadow
                                                      spreadRadius:
                                                          5, //spread radius
                                                      blurRadius:
                                                          7, // blur radius
                                                      offset: Offset(0,
                                                          2), // changes position of shadow
                                                      //first paramerter of offset is left-right
                                                      //second parameter is top to down
                                                    ),
                                                    //you can set more BoxShadow() here
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  //to clip overflown positioned containers.
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  //if we set border radius on container, the overflown content get displayed at corner.
                                                  child: Container(
                                                      child: Stack(
                                                    children: <Widget>[
                                                      //Stack helps to overlap widgets
                                                      Positioned(
                                                          //positioned helps to position widget wherever we want.
                                                          top: -20,
                                                          left:
                                                              -50, //position of the widget
                                                          child: Container(
                                                              height: 250,
                                                              width: 250,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: greyColor2
                                                                      .withOpacity(
                                                                          0.5) //background color with opacity
                                                                  ))),

                                                      Positioned(
                                                          left: -80,
                                                          top: -50,
                                                          child: Container(
                                                              height: 180,
                                                              width: 180,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5)))),

                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Text(
                                                                "Silver",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        30,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Text(
                                                                "NUTLOOP",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 30,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                        //main content container postition.
                                                        child: Container(
                                                            height: 250,
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Valid till -",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_view_month,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.0,
                                                                  ),
                                                                  Text(
                                                                    "Dec., 2022",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                  ]))
                            ])),
                  ]),
            ),
          )
          //   }
          // })
        ])));
  }
}

/// Clip widget in wave shape shape
class ClipPathClass extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  ClipPathClass({this.reverse = false, this.flip = false});

  @override
  Path getClip(Size size) {
    if (!reverse && !flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 30);
      Offset secondEndPoint = Offset(size.width, size.height - 50);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 10);

      final path = Path()
        ..lineTo(0.0, size.height)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (!reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, size.height - 20);
      Offset firstControlPoint = Offset(size.width * .25, size.height - 10);
      Offset secondEndPoint = Offset(size.width, size.height);
      Offset secondControlPoint = Offset(size.width * .75, size.height - 30);

      final path = Path()
        ..lineTo(0.0, size.height - 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, 0.0)
        ..close();
      return path;
    } else if (reverse && flip) {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 10);
      Offset secondEndPoint = Offset(size.width, 0);
      Offset secondControlPoint = Offset(size.width * .75, 30);

      final path = Path()
        ..lineTo(0, 30)
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    } else {
      Offset firstEndPoint = Offset(size.width * .5, 20);
      Offset firstControlPoint = Offset(size.width * .25, 30);
      Offset secondEndPoint = Offset(size.width, 50);
      Offset secondControlPoint = Offset(size.width * .75, 10);

      final path = Path()
        ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
            firstEndPoint.dx, firstEndPoint.dy)
        ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
            secondEndPoint.dx, secondEndPoint.dy)
        ..lineTo(size.width, size.height)
        ..lineTo(0.0, size.height)
        ..close();
      return path;
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
