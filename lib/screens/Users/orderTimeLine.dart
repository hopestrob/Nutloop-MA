import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/model/ordered.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/widget/checkOutAddCard.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:nuthoop/widget/orderTimeline.dart';
import 'package:provider/provider.dart';

import '../Home/widget/header.dart';
import 'help.dart' as help;

// ignore: must_be_immutable
class OrderTimeLineScreen extends StatefulWidget {
  final int id;
  final String status;
  final String date;
  final String address;
  final String orderNumber;
  final String deliveryMode;
  final String total;

  OrderTimeLineScreen(
      {this.id,
      this.status,
      this.date,
      this.address,
      this.orderNumber,
      this.deliveryMode,
      this.total});

  @override
  _OrderTimeLineScreenState createState() => _OrderTimeLineScreenState();
}

class _OrderTimeLineScreenState extends State<OrderTimeLineScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool taps = false;
  @override
  void didChangeDependencies() {
    // Provider.of<CartProvider>(context).getSavedCartItemsList();
    if (!mounted) return;
    Provider.of<CartProvider>(context, listen: false)
        .getSingleOrderedDetail(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            Container(child: header(context, "My Order")),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                color: greyColor5,
                child: ListView(children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    margin: EdgeInsets.all(20.0),
                    child: Selector<CartProvider, OrderedModel>(
                      selector: (_, order) => order.getOrderedSingleItem,
                      builder: (_, result, child) => result?.id == null
                          ? Center(
                              child: CupertinoActivityIndicator(
                              radius: 12,
                            ))
                          : Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Order Timeline",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  line(context),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20.0),
                                    child: Timeline(
                                      lineColor: result.orderStatus.id == 1
                                          ? kBrandColor
                                          : Colors.black,

                                      ///Both data needs to be provided every time. If you don't want to add detail then use single colons('')
                                      children: <Widget>[
                                        MapTextData(
                                          mainAddress: 'Ordered',
                                          textStyle: TextStyle(
                                              color: result.orderStatus.id == 1
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                          detailAddress: '${this.widget.date}',
                                          textStyle2: TextStyle(
                                              color: result.orderStatus.id == 1
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        MapTextData(
                                          mainAddress: 'Confirmed',
                                          textStyle: TextStyle(
                                              color: result.orderStatus.id == 2
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                          detailAddress: '${this.widget.date}',
                                          textStyle2: TextStyle(
                                              color: result.orderStatus.id == 2
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        MapTextData(
                                          mainAddress: 'Shipped',
                                          textStyle: TextStyle(
                                              color: result.orderStatus.id == 3
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                          detailAddress: '${this.widget.date}',
                                          textStyle2: TextStyle(
                                              color: result.orderStatus.id == 3
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        MapTextData(
                                          mainAddress: 'Out for Delivery',
                                          textStyle: TextStyle(
                                              color: result.orderStatus.id == 4
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                          detailAddress: '${this.widget.date}',
                                          textStyle2: TextStyle(
                                              color: result.orderStatus.id == 4
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        MapTextData(
                                          mainAddress: 'Delivered',
                                          textStyle: TextStyle(
                                              color: result.orderStatus.id == 5
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                          detailAddress: '${this.widget.date}',
                                          textStyle2: TextStyle(
                                              color: result.orderStatus.id == 5
                                                  ? kBrandColor
                                                  : Colors.black,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                      indicators: <Widget>[
                                        Icon(
                                            result.orderStatus.id == 1
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: result.orderStatus.id == 1
                                                ? kBrandColor
                                                : Colors.black),
                                        Icon(
                                            result.orderStatus.id == 2
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: result.orderStatus.id == 2
                                                ? kBrandColor
                                                : Colors.black),
                                        Icon(
                                            result.orderStatus.id == 3
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: result.orderStatus.id == 3
                                                ? kBrandColor
                                                : Colors.black),
                                        Icon(
                                            result.orderStatus.id == 4
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: result.orderStatus.id == 4
                                                ? kBrandColor
                                                : Colors.black),
                                        Icon(
                                            result.orderStatus.id == 5
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: result.orderStatus.id == 5
                                                ? kBrandColor
                                                : Colors.black),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Delivery Address",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          line(context),
                                          SizedBox(height: 20.0),
                                          Text(this.widget.address),
                                          SizedBox(height: 20.0),
                                        ]),
                                  ),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Order info",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          line(context),
                                          SizedBox(height: 10.0),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Total:"),
                                                Text('₦${this.widget.total}',
                                                    style: TextStyle(
                                                        color: kBrandColor))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Order Number:"),
                                                Text(this.widget.orderNumber,
                                                    style: TextStyle(
                                                        color: kBrandColor))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Delivery Method:"),
                                                Text(this.widget.deliveryMode,
                                                    style: TextStyle(
                                                        color: kBrandColor))
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: ElevatedButton(
                                                  // shape: RoundedRectangleBorder(
                                                  //     borderRadius:
                                                  //         BorderRadius.all(
                                                  //             Radius.circular(
                                                  //                 20.0))),
                                                  // color: kBrandColor,
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.0))),
                                                      primary: kBrandColor),
                                                  onPressed: null,
                                                  child: AutoSizeText(
                                                      'Track Order(Coming Soon)',
                                                      minFontSize: 12,
                                                      maxFontSize: 13,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Consumer<Authentication>(
                                                  builder:
                                                      (_, authuser, child) =>
                                                          ElevatedButton(
                                                    // shape: RoundedRectangleBorder(
                                                    //     borderRadius:
                                                    //         BorderRadius.all(
                                                    //             Radius.circular(
                                                    //                 20.0))),
                                                    // color: kBrandColor,
                                                    style: ElevatedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        primary: kBrandColor),
                                                    onPressed: () async {
                                                      if (!await context
                                                          .read<
                                                              Authentication>()
                                                          .sendContactMessage(
                                                              authuser
                                                                  .getSingleUserDetail
                                                                  ?.data
                                                                  ?.user
                                                                  ?.name
                                                                  .toString(),
                                                              authuser
                                                                  .getSingleUserDetail
                                                                  ?.data
                                                                  ?.user
                                                                  ?.email
                                                                  .toString(),
                                                              authuser
                                                                  .getSingleUserDetail
                                                                  ?.data
                                                                  ?.user
                                                                  ?.phoneNumber
                                                                  .toString(),
                                                              'Request a call back Ticket',
                                                              int.parse(1
                                                                  .toString()))) {
                                                        switch (context
                                                            .read<
                                                                Authentication>()
                                                            .sendContactState) {
                                                          case SendContactState
                                                              .initial:
                                                          case SendContactState
                                                              .loading:
                                                          case SendContactState
                                                              .complete:
                                                          case SendContactState
                                                              .error:
                                                            return
                                                                // print(
                                                                //     'this is the error ${Provider.of<Authentication>(context, listen: false).contactError.toString()}');
                                                                ScaffoldMessenger.of(context).showSnackBar(displayMessage(Provider.of<
                                                                            Authentication>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .contactError
                                                                    .toString()));
                                                        }
                                                      } else {
                                                        return ScaffoldMessenger
                                                                .of(context)
                                                            .showSnackBar(
                                                                displayMessage(
                                                                    'Message sent.. We will get back to you..thank you'));
                                                      }
                                                    },
                                                    child: sendContactMessgae(
                                                        context),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                    ),
                  )
                ]),
              ),
            )
          ]),
        ));
  }
}

Widget sendContactMessgae(BuildContext context) {
  switch (context.watch<Authentication>().sendContactState) {
    case SendContactState.initial:
      return AutoSizeText(
        'Request a call back',
        minFontSize: 12,
        maxFontSize: 13,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case SendContactState.loading:
      return Row(children: [
        CupertinoActivityIndicator(),
        AutoSizeText(
          'Sending...',
          minFontSize: 12,
          maxFontSize: 13,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ]);
    case SendContactState.error:
      return AutoSizeText(
        'Request a call back',
        minFontSize: 12,
        maxFontSize: 13,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case SendContactState.complete:
      return AutoSizeText(
        'Request a call back',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
  }
  return AutoSizeText(
    'Request a call back',
    minFontSize: 10,
    maxFontSize: 12,
    maxLines: 2,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  );
}
