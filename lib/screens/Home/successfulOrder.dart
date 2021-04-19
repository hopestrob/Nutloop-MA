import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';


class SuccessfulCheckOutPage extends StatefulWidget {
  final double amount;
  final List<CartItem> products;

  SuccessfulCheckOutPage({this.amount, this.products});

  @override
  _SuccessfulCheckOutPageState createState() => _SuccessfulCheckOutPageState();
}

class _SuccessfulCheckOutPageState extends State<SuccessfulCheckOutPage> {
  var currentSelectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor4,
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
        ]))));
  }
}
