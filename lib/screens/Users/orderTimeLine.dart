import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/checkOutAddCard.dart';
import 'package:nutloop_ecommerce/widget/orderTimeline.dart';

import '../Home/widget/header.dart';

// ignore: must_be_immutable
class OrderTimeLineScreen extends StatefulWidget {
  final String status;
  final String date;
  final String address;
  final String orderNumber;
  final String deliveryMode;
  final String total;

  OrderTimeLineScreen({this.status, this.date, this.address, this.orderNumber, this.deliveryMode, this.total});

  @override
  _OrderTimeLineScreenState createState() => _OrderTimeLineScreenState();
}

class _OrderTimeLineScreenState extends State<OrderTimeLineScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool taps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            Container(child: header(context, "My Orders")),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  margin: EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Order Timeline", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
                        ),
                        line(context),
                        Container(
                          // margin: EdgeInsets.only(left: 20.0),
                          child: Timeline(
                            lineColor: this.widget.status == "Delivery" ? kBrandColor : Colors.black,
                            ///Both data needs to be provided every time. If you don't want to add detail then use single colons('')
                            children: <Widget>[
                              MapTextData(
                                mainAddress: 'Ordered',
                                textStyle: TextStyle(
                                    color: this.widget.status == "Ordered" ? kBrandColor : Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                detailAddress: '${this.widget.date}',
                                textStyle2: TextStyle(
                                    color: this.widget.status == "Ordered" ? kBrandColor : Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              MapTextData(
                                mainAddress: 'Confirmed',
                                textStyle: TextStyle(
                                    color: this.widget.status == "Confirmed" ? kBrandColor : Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                detailAddress: '${this.widget.date}',
                                textStyle2: TextStyle(
                                    color: this.widget.status == "Confirmed" ? kBrandColor : Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              MapTextData(
                                mainAddress: 'Shipped',
                                textStyle: TextStyle(
                                    color: this.widget.status == "Shipped" ? kBrandColor : Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                detailAddress: '${this.widget.date}',
                                textStyle2: TextStyle(
                                    color: this.widget.status == "Shipped" ? kBrandColor : Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              MapTextData(
                                mainAddress: 'Out for Delivery',
                                textStyle: TextStyle(
                                    color: this.widget.status == "Out for Delivery" ? kBrandColor : Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                detailAddress: '${this.widget.date}',
                                textStyle2: TextStyle(
                                    color: this.widget.status == "Out for Delivery" ? kBrandColor : Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              MapTextData(
                                mainAddress: 'Delivered',
                                textStyle: TextStyle(
                                    color: this.widget.status == "Delivered" ? kBrandColor : Colors.black,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                detailAddress: '${this.widget.date}',
                                textStyle2: TextStyle(
                                    color: this.widget.status == "Delivered" ? kBrandColor : Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                            indicators: <Widget>[
                              Icon(this.widget.status == "Ordered" ? Icons.check_circle: Icons.radio_button_unchecked, 
                              color: this.widget.status == "Ordered" ? kBrandColor : Colors.black),
                              Icon(this.widget.status == "Confirmed" ? Icons.check_circle: Icons.radio_button_unchecked, 
                              color: this.widget.status == "Confirmed" ? kBrandColor : Colors.black),
                              Icon(this.widget.status == "Shipped" ? Icons.check_circle: Icons.radio_button_unchecked, 
                              color: this.widget.status == "Shipped" ? kBrandColor : Colors.black),
                              Icon(this.widget.status == "Out for Delivery" ? Icons.check_circle: Icons.radio_button_unchecked, 
                              color: this.widget.status == "Out for Delivery" ? kBrandColor : Colors.black),
                              Icon(this.widget.status == "Delivered" ? Icons.check_circle: Icons.radio_button_unchecked, 
                              color: this.widget.status == "Delivered" ? kBrandColor : Colors.black),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Text("Delivery Address", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Order info", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
                                line(context),
                                SizedBox(height: 10.0),
                                   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Total:"),
                            Text(this.widget.total, style: TextStyle(color:kBrandColor))
                          ],),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Order Number:"),
                            Text(this.widget.orderNumber, style: TextStyle(color:kBrandColor))
                          ],),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Text("Delivery Method:"),
                            Text(this.widget.deliveryMode, style: TextStyle(color:kBrandColor))
                          ],),
                        ),
                              ]),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ))
          ]),
        ));
  }
}
