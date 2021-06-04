import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nutloop_ecommerce/model/ordered.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
// import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/config_size.dart';
import 'addCard.dart';
import 'orderTimeLine.dart';

// ignore: must_be_immutable
class OrdersDetailsScreen extends StatefulWidget {
  @override
  _OrdersDetailsScreenState createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ordersDetails = Provider.of<List<OrderedModel>>(context);
    // print(.length);
    Size size = MediaQuery.of(context).size;
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
                      'My Orders',
                      style: TextStyle(
                          color: kBrandColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          )),
          SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
          (ordersDetails == null)
              ?
              // Center(
              //     child: CupertinoActivityIndicator(
              //     radius: 12,
              //   ))
              SizedBox(
                  width: 200.0,
                  height: 500,
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
                )
              : (ordersDetails.length == 0)
                  ? Expanded(
                      child: Container(
                        color: greyColor5,
                        child: ListView(
                          children: [
                            SizedBox(height: size.height * 0.150),
                            SvgPicture.asset(
                              "asset/cart.svg",
                              height: size.width * 0.330,
                              color: kBrandColor,
                            ),
                            Container(
                                width: 250,
                                margin: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'You currently have no orders yet!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24.0),
                                )),

                            Container(
                              margin: EdgeInsets.all(
                                  5.0 * SizeConfig.widthMultiplier),
                              width: 95 * SizeConfig.widthMultiplier,
                              padding: EdgeInsets.all(10.0),
                              // width: size.width / 1.2,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: TextButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  var authNames = prefs.getString('authName');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Homepage(authName: authNames)));
                                },
                                child: Text(
                                  'Continue Shopping',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.020),

                            // Container(
                            //          margin: EdgeInsets.all(10.0),
                            //          child: Row(
                            //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //            children: [
                            //              Text(
                            //                'Top Selling Items',
                            //                style: TextStyle(fontWeight: FontWeight.bold),
                            //              ),

                            //            ],
                            //          ),
                            //        ),
                            //  FeaturedProduct(),
                            // SizedBox(height: 20.0),
                            //  line(context),

                            //   Container(
                            //    margin: EdgeInsets.all(10.0),
                            //    child: Row(
                            //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //      children: [
                            //        Text(
                            //          'Recently Viewed',
                            //          style: TextStyle(fontWeight: FontWeight.bold),
                            //        ),

                            //      ],
                            //    ),
                            //  ),
                            //  ListProduct(),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              DefaultTabController(
                                  length: 3, // length of tabs
                                  initialIndex: 0,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: TabBar(
                                            labelColor: Colors.white,
                                            unselectedLabelColor: Colors.black,
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            indicator: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.grey,
                                                      Colors.grey
                                                    ]),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.redAccent),
                                            tabs: [
                                              Tab(text: 'All'),
                                              Tab(text: 'Open Orders'),
                                              Tab(text: 'Closed Orders'),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 550, //height of TabBarView
                                            // decoration: BoxDecoration(
                                            //     border: Border(
                                            //         top: BorderSide(
                                            //             color: Colors.grey,
                                            //             width: 0.5))),
                                            child: TabBarView(
                                                children: <Widget>[
                                                  // Consumer<CartProvider>(
                                                  //     builder: (_, cart,
                                                  //             child) =>
                                                  SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                          ordersDetails
                                                                  ?.length ??
                                                              0, (index) {
                                                        var orderedItem =
                                                            ordersDetails[
                                                                index];
                                                        return Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20.0))),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  20.0),
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
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Order Date: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                kBrandColor,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                line(context),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Total: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      Text(
                                                                          "${orderedItem.total}",
                                                                          style:
                                                                              TextStyle(color: kBrandColor))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                          "Order Number:",
                                                                          style:
                                                                              TextStyle(color: Colors.black)),
                                                                      Text(
                                                                          "${orderedItem.orderNo}",
                                                                          style:
                                                                              TextStyle(color: kBrandColor))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "Delivery Method: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                      Text(
                                                                          "${orderedItem.deliveryMode}",
                                                                          style:
                                                                              TextStyle(color: kBrandColor))
                                                                    ],
                                                                  ),
                                                                ),
                                                                line(context),
                                                                SizedBox(
                                                                    height:
                                                                        20.0),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          "Delivery Address",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold)),
                                                                      SizedBox(
                                                                          height:
                                                                              20.0),
                                                                      // Text(
                                                                      // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                      // Text("${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + Provider.of<Authentication>(context).getAddressBook.street + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                      // SizedBox(height: 20.0),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          ElevatedButton(
                                                                            // shape: RoundedRectangleBorder(
                                                                            //     borderRadius:
                                                                            //         BorderRadius.all(
                                                                            //             Radius.circular(
                                                                            //                 20.0))),
                                                                            // color: kBrandColor,
                                                                            style:
                                                                                ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), primary: kBrandColor),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => OrderTimeLineScreen(
                                                                                            status: orderedItem.orderStatus.name,
                                                                                            date: "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                                            address: 'address',
                                                                                            // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                            orderNumber: orderedItem.orderNo,
                                                                                            deliveryMode: orderedItem.deliveryMode,
                                                                                            total: orderedItem.total.toString(),
                                                                                          )));
                                                                            },
                                                                            child:
                                                                                Text('Order Timeline', style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 5.0),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              primary: Colors.white,
                                                                              side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                              // color: kBrandColor,
                                                                            ),
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Text('Cancel Order', style: TextStyle(color: kBrandColor)),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  Container(
                                                      child:
                                                          // Consumer<
                                                          //         CartProvider>(
                                                          //     builder: (_, cart,
                                                          //             child) =>
                                                          SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                          ordersDetails
                                                                  ?.length ??
                                                              0, (index) {
                                                        var orderedItem =
                                                            ordersDetails[
                                                                index];
                                                        return orderedItem
                                                                    .orderStatusesId ==
                                                                1
                                                            ? Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                margin: EdgeInsets
                                                                    .all(20.0),
                                                                child:
                                                                    Container(
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
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Order Date: ",
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                              style: TextStyle(color: kBrandColor, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Total: ",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            Text("${orderedItem.total}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text("Order Number:",
                                                                                style: TextStyle(color: Colors.black)),
                                                                            Text("${orderedItem.orderNo}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Delivery Method: ",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            Text("${orderedItem.deliveryMode}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      SizedBox(
                                                                          height:
                                                                              20.0),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text("Delivery Address",
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                                            SizedBox(height: 20.0),
                                                                            // Text(
                                                                            // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                            // Text("${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + Provider.of<Authentication>(context).getAddressBook.street + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                            // SizedBox(height: 20.0),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                ElevatedButton(
                                                                                  // shape: RoundedRectangleBorder(
                                                                                  //     borderRadius:
                                                                                  //         BorderRadius.all(
                                                                                  //             Radius.circular(
                                                                                  //                 20.0))),
                                                                                  // color: kBrandColor,
                                                                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), primary: kBrandColor),
                                                                                  onPressed: () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => OrderTimeLineScreen(
                                                                                                  status: orderedItem.orderStatus.name,
                                                                                                  date: "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                                                  address: 'address',
                                                                                                  // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                                  orderNumber: orderedItem.orderNo,
                                                                                                  deliveryMode: orderedItem.deliveryMode,
                                                                                                  total: orderedItem.total.toString(),
                                                                                                )));
                                                                                  },
                                                                                  child: Text('Order Timeline', style: TextStyle(color: Colors.white)),
                                                                                ),
                                                                                SizedBox(width: 5.0),
                                                                                ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.white,
                                                                                    side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                    // color: kBrandColor,
                                                                                  ),
                                                                                  onPressed: () {},
                                                                                  child: Text('Cancel Order', style: TextStyle(color: kBrandColor)),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'No Open Order',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              );
                                                      }),
                                                    ),
                                                  )),
                                                  // ),
                                                  Container(
                                                      child:
                                                          // Consumer<
                                                          //         CartProvider>(
                                                          //     builder: (_, cart,
                                                          //             child) =>
                                                          SingleChildScrollView(
                                                    child: Column(
                                                      children: List.generate(
                                                          ordersDetails
                                                                  ?.length ??
                                                              0, (index) {
                                                        var orderedItem =
                                                            ordersDetails[
                                                                index];
                                                        return orderedItem
                                                                    .orderStatusesId ==
                                                                2
                                                            ? Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                margin: EdgeInsets
                                                                    .all(20.0),
                                                                child:
                                                                    Container(
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
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Order Date: ",
                                                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                              style: TextStyle(color: kBrandColor, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Total: ",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            Text("${orderedItem.total}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text("Order Number:",
                                                                                style: TextStyle(color: Colors.black)),
                                                                            Text("${orderedItem.orderNo}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "Delivery Method: ",
                                                                              style: TextStyle(color: Colors.black),
                                                                            ),
                                                                            Text("${orderedItem.deliveryMode}",
                                                                                style: TextStyle(color: kBrandColor))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      SizedBox(
                                                                          height:
                                                                              20.0),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text("Delivery Address",
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                                            SizedBox(height: 20.0),
                                                                            // Text(
                                                                            // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                            // Text("${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + Provider.of<Authentication>(context).getAddressBook.street + Provider.of<Authentication>(context).getAddressBook.city : " "}"),
                                                                            // SizedBox(height: 20.0),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                ElevatedButton(
                                                                                  // shape: RoundedRectangleBorder(
                                                                                  //     borderRadius:
                                                                                  //         BorderRadius.all(
                                                                                  //             Radius.circular(
                                                                                  //                 20.0))),
                                                                                  // color: kBrandColor,
                                                                                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), primary: kBrandColor),
                                                                                  onPressed: () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => OrderTimeLineScreen(
                                                                                                  status: orderedItem.orderStatus.name,
                                                                                                  date: "${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                                                  address: 'address',
                                                                                                  // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                                  orderNumber: orderedItem.orderNo,
                                                                                                  deliveryMode: orderedItem.deliveryMode,
                                                                                                  total: orderedItem.total.toString(),
                                                                                                )));
                                                                                  },
                                                                                  child: Text('Order Timeline', style: TextStyle(color: Colors.white)),
                                                                                ),
                                                                                SizedBox(width: 5.0),
                                                                                ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.white,
                                                                                    side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                    // color: kBrandColor,
                                                                                  ),
                                                                                  onPressed: () {},
                                                                                  child: Text('Cancel Order', style: TextStyle(color: kBrandColor)),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'No Closed Order available',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              );
                                                      }),
                                                    ),
                                                  )),
                                                  // ),
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
