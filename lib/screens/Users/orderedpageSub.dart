// import 'dart:convert';

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/ordered.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
// import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Users/reportView.dart';
// import 'package:nuthoop/screens/Home/bottomNav.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/config_size.dart';
import 'addCard.dart';
import 'orderTimeLine.dart';

// ignore: must_be_immutable
class OrdersDetailsSubScreen extends StatefulWidget {
  @override
  _OrdersDetailsSubScreenState createState() => _OrdersDetailsSubScreenState();
}

class _OrdersDetailsSubScreenState extends State<OrdersDetailsSubScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    Provider.of<Authentication>(context, listen: false)
        .getAddressInOrderDetail(context);
    Provider.of<CartProvider>(context, listen: false).getOrdered();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    Provider.of<Authentication>(context, listen: false)
        .getAddressInOrderDetail(context);
    Provider.of<CartProvider>(context, listen: false).getOrdered();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersDetails =
    //     Provider.of<CartProvider>(context, listen: false).getOrderedItem;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Selector<CartProvider, List<OrderedModel>>(
              selector: (_, cart) => cart.getOrderedItem,
              builder: (_, List<OrderedModel> ordersDetails, child) {
                return Column(children: [
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
                              'My Orders',
                              style: TextStyle(
                                  color: kBrandColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  )),
                  SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                  ordersDetails.length == null
                      ? Center(
                          child: CupertinoActivityIndicator(
                          radius: 12,
                        ))
                      : (ordersDetails.length > 0)
                          ? Expanded(
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
                                          gradient: LinearGradient(colors: [
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
                                  Expanded(
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        // first tab bar view widget
                                        Selector<CartProvider,
                                            List<OrderedModel>>(
                                          selector: (_, order) =>
                                              order.getOrderedItem,
                                          builder:
                                              (_, ordersDetail, child) =>
                                                  ListView.builder(
                                                      reverse:
                                                          ordersDetail.length >
                                                                  1
                                                              ? true
                                                              : false,
                                                      itemCount:
                                                          ordersDetail.length ??
                                                              0,
                                                      itemBuilder: (_, index) {
                                                        var orderedItem =
                                                            ordersDetail[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical:
                                                                      15.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20.0,
                                                                  vertical: 2.0,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
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
                                                                            const EdgeInsets.all(15.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Order Timeline',
                                                                          maxFontSize:
                                                                              16,
                                                                          minFontSize:
                                                                              14,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Order no.: ${orderedItem.orderNo}',
                                                                          maxFontSize:
                                                                              16,
                                                                          minFontSize:
                                                                              14,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          '${orderedItem.items.length} items',
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Placed on:  ${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0,
                                                                            bottom:
                                                                                30.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Total:  ₦${orderedItem.total}",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            20.0,
                                                                        vertical:
                                                                            2.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
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
                                                                            const EdgeInsets.all(15.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Items in your order',
                                                                          maxFontSize:
                                                                              16,
                                                                          minFontSize:
                                                                              14,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Status: ${orderedItem.orderStatus.name}',
                                                                          maxFontSize:
                                                                              16,
                                                                          minFontSize:
                                                                              14,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "On ${DateFormat.yMMMEd().format(DateTime.parse(orderedItem.createdAt.toString()))}",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0,
                                                                            bottom:
                                                                                10.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Your orders has been confirmed and will be shipped soon",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Column(
                                                                        children: List.generate(
                                                                            orderedItem.items.length,
                                                                            (index) {
                                                                          var image = json.decode(orderedItem
                                                                              .items[index]
                                                                              .product
                                                                              .images) as List;
                                                                          var itemProduct =
                                                                              orderedItem.items[index];
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 20.0,
                                                                              top: 10.0,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                //  == null ? CircularProgressIndicator() :
                                                                                Row(
                                                                                  children: [
                                                                                    ...image
                                                                                        // .where((e) => e.unitId == 1)
                                                                                        .map((e) {
                                                                                      return Container(
                                                                                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                                                                                        width: MediaQuery.of(context).size.width / 5.0,
                                                                                        height: MediaQuery.of(context).size.width / 5.0,
                                                                                        // 117,
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                                                                        ),
                                                                                        child: Image.network(
                                                                                          "${Api.imageUrl}${e.toString()}",
                                                                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                                                            if (loadingProgress == null) return child;
                                                                                            return Center(
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: new AlwaysStoppedAnimation<Color>(kBrandColor),
                                                                                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                          fit: BoxFit.fill,
                                                                                        ),
                                                                                      );
                                                                                    }),
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                          child: AutoSizeText(
                                                                                            '${itemProduct.product.name}',
                                                                                            maxFontSize: 13,
                                                                                            minFontSize: 12,
                                                                                            maxLines: 2,
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                          child: AutoSizeText(
                                                                                            'Measurement: ${itemProduct.unitDetails.name}',
                                                                                            maxFontSize: 13,
                                                                                            minFontSize: 12,
                                                                                            maxLines: 2,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                          child: AutoSizeText(
                                                                                            'Qty: ${itemProduct.quantity}',
                                                                                            maxFontSize: 13,
                                                                                            minFontSize: 12,
                                                                                            maxLines: 2,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 30.0),
                                                                                          child: AutoSizeText(
                                                                                            "₦${itemProduct.price}",
                                                                                            maxFontSize: 13,
                                                                                            minFontSize: 12,
                                                                                            maxLines: 2,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10.0))),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20.0,
                                                                  vertical: 2.0,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
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
                                                                            const EdgeInsets.all(15.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Payment',
                                                                          maxFontSize:
                                                                              16,
                                                                          minFontSize:
                                                                              14,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Payment Method',
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          '${orderedItem.paymentMode == 'Online' ? 'Card Payment' : 'Wallet Method'}',
                                                                          maxFontSize:
                                                                              18,
                                                                          minFontSize:
                                                                              16,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(color: productColor),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                10.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Subtotal: ₦${orderedItem.subTotal}',
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Shipping Fee:  ₦${orderedItem.deliveryCharges}",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                4.0,
                                                                            bottom:
                                                                                30.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Total:  ₦${orderedItem.total}",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Card(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20.0))),
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20.0,
                                                                  vertical: 2.0,
                                                                ),
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
                                                                            Text(
                                                                          "Delivery",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      line(
                                                                          context),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                        ),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "Delivery Option",
                                                                          maxFontSize:
                                                                              13,
                                                                          minFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              10.0,
                                                                        ),
                                                                        child:
                                                                            AutoSizeText(
                                                                          "${orderedItem.deliveryMode}",
                                                                          maxFontSize:
                                                                              18,
                                                                          minFontSize:
                                                                              16,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(color: Colors.grey),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              10.0,
                                                                        ),
                                                                        child: Consumer<Authentication>(builder: (context,
                                                                            addressbookdetails,
                                                                            child) {
                                                                          // final product;
                                                                          return Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Text("Delivery Address", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                                              SizedBox(height: 20.0),
                                                                              (addressbookdetails.getAddressBook == null) ? Text('loading...') : Text("${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}"),
                                                                              SizedBox(height: 20.0),
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
                                                                                                    id: orderedItem.id,
                                                                                                    status: orderedItem.orderStatus.name,
                                                                                                    date: "${orderedItem.orderStatus.createdAt == null ? DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt)) : DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.orderStatus.createdAt))}",
                                                                                                    address: (addressbookdetails == null) ? '' : "${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}",
                                                                                                    // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                                    orderNumber: orderedItem.orderNo,
                                                                                                    deliveryMode: orderedItem.deliveryMode,
                                                                                                    total: orderedItem.total.toString(),
                                                                                                  )));
                                                                                    },
                                                                                    child: Text('Order timeline', style: TextStyle(color: Colors.white)),
                                                                                  ),
                                                                                  // SizedBox(
                                                                                  //     width: 5.0),
                                                                                  // ElevatedButton(
                                                                                  //   style:
                                                                                  //       ElevatedButton.styleFrom(
                                                                                  //     primary: Colors.white,
                                                                                  //     side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                  //     // color: kBrandColor,
                                                                                  //   ),
                                                                                  //   onPressed:
                                                                                  //       () {
                                                                                  //     // reportView(context);
                                                                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                  //   },
                                                                                  //   child:
                                                                                  //       Text('Share Receipt', style: TextStyle(color: kBrandColor)),
                                                                                  // ),
                                                                                  SizedBox(width: 5.0),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(right: 8.0),
                                                                                    child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        primary: Colors.white,
                                                                                        side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                        // color: kBrandColor,
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        reportView(context, orderedItem, addressbookdetails.getAddressBook);
                                                                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                      },
                                                                                      child: Text('Payment Receipt', style: TextStyle(color: kBrandColor)),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          );
                                                                        }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                        ),

                                        // second tab bar view widget
                                        Consumer<CartProvider>(
                                          builder: (_, ordersDetail, child) =>
                                              SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                  ordersDetail.getOrderedItem
                                                          ?.length ??
                                                      0, (index) {
                                                var orderedItem = ordersDetail
                                                    .getOrderedItem[index];
                                                return orderedItem
                                                            .orderStatusesId ==
                                                        1
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 15.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Order Timeline',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Order no.: ${orderedItem.orderNo}',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orderedItem.items.length} items',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Placed on:  ${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              30.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Total:  ₦${orderedItem.total}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.0,
                                                                      vertical:
                                                                          2.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Items in your order',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Status: ${orderedItem.orderStatus.name}',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "On ${DateFormat.yMMMEd().format(DateTime.parse(orderedItem.createdAt.toString()))}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              10.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Your orders has been confirmed and will be shipped soon",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Column(
                                                                      children: List.generate(
                                                                          orderedItem
                                                                              .items
                                                                              .length,
                                                                          (index) {
                                                                        var image = json.decode(orderedItem
                                                                            .items[index]
                                                                            .product
                                                                            .images) as List;
                                                                        var itemProduct =
                                                                            orderedItem.items[index];
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                10.0,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              //  == null ? CircularProgressIndicator() :
                                                                              Row(
                                                                                children: [
                                                                                  ...image
                                                                                      // .where((e) => e.unitId == 1)
                                                                                      .map((e) {
                                                                                    return Container(
                                                                                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                                                                                      width: MediaQuery.of(context).size.width / 5.0,
                                                                                      height: MediaQuery.of(context).size.width / 5.0,
                                                                                      // 117,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        "${Api.imageUrl}${e.toString()}",
                                                                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                                                          if (loadingProgress == null) return child;
                                                                                          return Center(
                                                                                            child: CircularProgressIndicator(
                                                                                              valueColor: new AlwaysStoppedAnimation<Color>(kBrandColor),
                                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                                  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          '${itemProduct.product.name}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          'Measurement: ${itemProduct.unitDetails.name}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          'Qty: ${itemProduct.quantity}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 30.0),
                                                                                        child: AutoSizeText(
                                                                                          "₦${itemProduct.price}",
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Payment',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Payment Method',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orderedItem.paymentMode == 'Online' ? 'Card Payment' : 'Wallet Method'}',
                                                                        maxFontSize:
                                                                            18,
                                                                        minFontSize:
                                                                            16,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                productColor),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              10.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Subtotal: ₦${orderedItem.subTotal}',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Shipping Fee:  ₦${orderedItem.deliveryCharges}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              30.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Total:  ₦${orderedItem.total}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
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
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "Delivery",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Delivery Option",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            10.0,
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "${orderedItem.deliveryMode}",
                                                                        maxFontSize:
                                                                            18,
                                                                        minFontSize:
                                                                            16,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            10.0,
                                                                      ),
                                                                      child: Consumer<Authentication>(builder: (context,
                                                                          addressbookdetails,
                                                                          child) {
                                                                        // final product;
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text("Delivery Address",
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                                            SizedBox(height: 20.0),
                                                                            (addressbookdetails.getAddressBook == null)
                                                                                ? Text('loading...')
                                                                                : Text("${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}"),
                                                                            SizedBox(height: 20.0),
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
                                                                                                  id: orderedItem.id,
                                                                                                  status: orderedItem.orderStatus.name,
                                                                                                  date: "${orderedItem.orderStatus.createdAt == null ? DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt)) : DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.orderStatus.createdAt))}",
                                                                                                  address: (addressbookdetails == null) ? '' : "${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}",
                                                                                                  // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                                  orderNumber: orderedItem.orderNo,
                                                                                                  deliveryMode: orderedItem.deliveryMode,
                                                                                                  total: orderedItem.total.toString(),
                                                                                                )));
                                                                                  },
                                                                                  child: Text('Order timeline', style: TextStyle(color: Colors.white)),
                                                                                ),
                                                                                // SizedBox(
                                                                                //     width: 5.0),
                                                                                // ElevatedButton(
                                                                                //   style:
                                                                                //       ElevatedButton.styleFrom(
                                                                                //     primary: Colors.white,
                                                                                //     side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                //     // color: kBrandColor,
                                                                                //   ),
                                                                                //   onPressed:
                                                                                //       () {
                                                                                //     // reportView(context);
                                                                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                //   },
                                                                                //   child:
                                                                                //       Text('Share Receipt', style: TextStyle(color: kBrandColor)),
                                                                                // ),
                                                                                SizedBox(width: 5.0),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 8.0),
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      primary: Colors.white,
                                                                                      side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                      // color: kBrandColor,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      reportView(context, orderedItem, addressbookdetails.getAddressBook);
                                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                    },
                                                                                    child: Text('Payment Receipt', style: TextStyle(color: kBrandColor)),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Text('No Open Order yet');
                                              }),
                                            ),
                                          ),
                                        ),
                                        Consumer<CartProvider>(
                                          builder: (_, ordersDetail, child) =>
                                              SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(
                                                  ordersDetail.getOrderedItem
                                                          ?.length ??
                                                      0, (index) {
                                                var orderedItem = ordersDetail
                                                    .getOrderedItem[index];
                                                return orderedItem
                                                            .orderStatusesId ==
                                                        4
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 15.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Order Timeline',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Order no.: ${orderedItem.orderNo}',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orderedItem.items.length} items',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Placed on:  ${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).year}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).month}-${DateFormat('yyyy-MM-dd').parse(orderedItem.createdAt).day}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              30.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Total:  ₦${orderedItem.total}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.0,
                                                                      vertical:
                                                                          2.0),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Items in your order',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Status: ${orderedItem.orderStatus.name}',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "On ${DateFormat.yMMMEd().format(DateTime.parse(orderedItem.createdAt.toString()))}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              10.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Your orders has been confirmed and will be shipped soon",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Column(
                                                                      children: List.generate(
                                                                          orderedItem
                                                                              .items
                                                                              .length,
                                                                          (index) {
                                                                        var image = json.decode(orderedItem
                                                                            .items[index]
                                                                            .product
                                                                            .images) as List;
                                                                        var itemProduct =
                                                                            orderedItem.items[index];
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            left:
                                                                                20.0,
                                                                            top:
                                                                                10.0,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              //  == null ? CircularProgressIndicator() :
                                                                              Row(
                                                                                children: [
                                                                                  ...image
                                                                                      // .where((e) => e.unitId == 1)
                                                                                      .map((e) {
                                                                                    return Container(
                                                                                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                                                                                      width: MediaQuery.of(context).size.width / 5.0,
                                                                                      height: MediaQuery.of(context).size.width / 5.0,
                                                                                      // 117,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                                                                                      ),
                                                                                      child: Image.network(
                                                                                        "${Api.imageUrl}${e.toString()}",
                                                                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                                                          if (loadingProgress == null) return child;
                                                                                          return Center(
                                                                                            child: CircularProgressIndicator(
                                                                                              valueColor: new AlwaysStoppedAnimation<Color>(kBrandColor),
                                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null,
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        fit: BoxFit.fill,
                                                                                      ),
                                                                                    );
                                                                                  }),
                                                                                  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          '${itemProduct.product.name}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          'Measurement: ${itemProduct.unitDetails.name}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 10.0),
                                                                                        child: AutoSizeText(
                                                                                          'Qty: ${itemProduct.quantity}',
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 20.0, top: 4.0, bottom: 30.0),
                                                                                        child: AutoSizeText(
                                                                                          "₦${itemProduct.price}",
                                                                                          maxFontSize: 13,
                                                                                          minFontSize: 12,
                                                                                          maxLines: 2,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Payment',
                                                                        maxFontSize:
                                                                            16,
                                                                        minFontSize:
                                                                            14,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Payment Method',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        '${orderedItem.paymentMode == 'Online' ? 'Card Payment' : 'Wallet Method'}',
                                                                        maxFontSize:
                                                                            18,
                                                                        minFontSize:
                                                                            16,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                productColor),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              10.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'Subtotal: ₦${orderedItem.subTotal}',
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Shipping Fee:  ₦${orderedItem.deliveryCharges}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20.0,
                                                                          top:
                                                                              4.0,
                                                                          bottom:
                                                                              30.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Total:  ₦${orderedItem.total}",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Card(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 2.0,
                                                              ),
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
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "Delivery",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    line(
                                                                        context),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "Delivery Option",
                                                                        maxFontSize:
                                                                            13,
                                                                        minFontSize:
                                                                            12,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            10.0,
                                                                      ),
                                                                      child:
                                                                          AutoSizeText(
                                                                        "${orderedItem.deliveryMode}",
                                                                        maxFontSize:
                                                                            18,
                                                                        minFontSize:
                                                                            16,
                                                                        maxLines:
                                                                            2,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20.0,
                                                                        top:
                                                                            4.0,
                                                                        bottom:
                                                                            10.0,
                                                                      ),
                                                                      child: Consumer<Authentication>(builder: (context,
                                                                          addressbookdetails,
                                                                          child) {
                                                                        // final product;
                                                                        return Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text("Delivery Address",
                                                                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                                                            SizedBox(height: 20.0),
                                                                            (addressbookdetails.getAddressBook == null)
                                                                                ? Text('loading...')
                                                                                : Text("${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}"),
                                                                            SizedBox(height: 20.0),
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
                                                                                                  id: orderedItem.id,
                                                                                                  status: orderedItem.orderStatus.name,
                                                                                                  date: "${orderedItem.orderStatus.createdAt == null ? DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.createdAt)) : DateFormat('EEEE, d MMM, yyyy').format(DateTime.parse(orderedItem.orderStatus.createdAt))}",
                                                                                                  address: (addressbookdetails == null) ? '' : "${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.houseNo).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.street).join()} ${addressbookdetails.getAddressBook.where((e) => e.id == orderedItem.addressId).map((e) => e.city).join()}",
                                                                                                  // "${Provider.of<Authentication>(context).getAddressBook.id == orderedItem.addressId ? Provider.of<Authentication>(context).getAddressBook.houseNo + ' ' + Provider.of<Authentication>(context).getAddressBook.street + ' ' + Provider.of<Authentication>(context).getAddressBook.city : " "}",
                                                                                                  orderNumber: orderedItem.orderNo,
                                                                                                  deliveryMode: orderedItem.deliveryMode,
                                                                                                  total: orderedItem.total.toString(),
                                                                                                )));
                                                                                  },
                                                                                  child: Text('Order timeline', style: TextStyle(color: Colors.white)),
                                                                                ),
                                                                                // SizedBox(
                                                                                //     width: 5.0),
                                                                                // ElevatedButton(
                                                                                //   style:
                                                                                //       ElevatedButton.styleFrom(
                                                                                //     primary: Colors.white,
                                                                                //     side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                //     // color: kBrandColor,
                                                                                //   ),
                                                                                //   onPressed:
                                                                                //       () {
                                                                                //     // reportView(context);
                                                                                //     Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                //   },
                                                                                //   child:
                                                                                //       Text('Share Receipt', style: TextStyle(color: kBrandColor)),
                                                                                // ),
                                                                                SizedBox(width: 5.0),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 8.0),
                                                                                  child: ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      primary: Colors.white,
                                                                                      side: BorderSide(width: 1.0, color: kBrandColor), // primary: Colors.white,
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                                      // color: kBrandColor,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      reportView(context, orderedItem, addressbookdetails.getAddressBook);
                                                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderRecieptScreen()));
                                                                                    },
                                                                                    child: Text('Payment Receipt', style: TextStyle(color: kBrandColor)),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Text(
                                                        'No orders have been completed');
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //   }
                                ],
                              ),
                            )
                          : Expanded(
                              child: Container(
                                color: greyColor5,
                                child: Center(
                                    child: Text(
                                  'You currently have no orders yet!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 24.0),
                                )),
                              ),
                            ) // tab bar view here

                  // })
                ]);
              })),
    );
  }
}
